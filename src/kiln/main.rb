require 'sketchup'

# √ how to get bounding box l,w,h
# √ how to rotate component (Geom.Transformation.something...)
# √ how to tweak rubocop to not complain about 15 line methods
# √ create a layer and assign a course to it Layout::Layer ? or Layout::Label
# √ iterate over all instances and sum by type
# how to define my own units?
# how to create ruby DSL?
# course a
# course b
# header course
# bagwall & primary air
# arches
# build the cast headers

# Monty::KilnTool.reload_files
module Monty
  # Kiln builder
  module KilnTool
    @index = 0
    @height = -3.5
    @unit = 4.5
    @layer = nil
    def self.create_kiln
      model = Sketchup.active_model
      model.start_operation('Create Kiln', true)
      create_slab
      create_concrete_block_base
      create_ifb_floor
      create_fb_tile_floor
      create_brick_row4
      model.commit_operation
      hash = {}
      Sketchup.active_model.entities.each do |instance|
        hash[instance.definition.name] = hash.key?(instance.definition.name) ? hash[instance.definition.name] + 1 : 1
      end
      hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def self.create_brick_row4
      add_kiln_layer
      # col 0
      bx = 0
      by = 0
      20.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      # col 1
      bx += 1
      lay_brick('IFB', bx, by)
      by += 2
      lay_brick('FB/2', bx, by)
      by += 1
      18.times do |i|
        lay_brick('FB', bx, (i * 2) + by)
      end
      by += 17 * 2
      # col 2
      bx += 1
      by = 0
      3.times do |i|
        lay_brick('FB', bx, (i * 2) + by)
      end
      lay_bagwall_a()
      # col 3
      bx += 1
      # col 4
      bx += 1
      lay_brick('FB', bx, by)
      lay_brick_rotated('FB', bx, by + 2)
      lay_brick_rotated('FB', bx, by + 3)
      lay_brick('FB', bx, by + 4)
      # col 5
      bx += 1
      lay_brick('FB', bx, by)
      lay_brick('FB', bx, by + 4)
      # col 6
      bx += 1
      # col 7
      bx += 1
      3.times do |i|
        lay_brick('FB', bx, (i * 2) + by)
      end
      # col 8
      bx += 1
      lay_brick('IFB', bx, by)
      lay_brick('FB/2', bx, by + 2)
      lay_brick('FB', bx, by + 3)
      lay_brick('FB/2', bx, by + 5)
      by = 8
      16.times do |i|
        lay_brick('FB', bx, (i * 2) + by)
      end
      # col 9
      bx += 1
      by = 0
      lay_brick('IFB', bx, by)
      lay_brick('IFB', bx, by + 2)
      lay_brick('FB', bx, by + 4)
      by = 8
      lay_brick('FB', bx, by)
      lay_brick('IFB/2', bx, by + 2)
      lay_brick('IFB', bx, by + 3)
      lay_brick('IFB', bx, by + 5)
      lay_brick('FB', bx, by + 7)
      lay_brick('IFB', bx, by + 9)
      lay_brick('IFB', bx, by + 11)
      lay_brick('FB', bx, by + 13)
      by += 15
      8.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      @height += 2.5
    end

    def self.lay_bagwall_a()
      (2..7).each do |bx|
        lay_brick('FB/2', bx, 29)
        lay_brick('FB', bx, 30)
        lay_brick('FB', bx, 36)
        lay_brick('FB/2', bx, 38)
      end
    end

    def self.lay_brick(brick_type, bx, by)
      componentdefinition = find_componentdefinition(brick_type)
      transformation = Geom::Transformation.new([bx * @unit, by * @unit, @height])
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
    end

    def self.lay_brick_rotated(brick_type, bx, by)
      componentdefinition = find_componentdefinition(brick_type)
      w = componentdefinition.bounds.height
      target_point = Geom::Point3d.new(0, 0, 0)
      vector = Geom::Vector3d.new(0, 0, 1)
      degrees_to_rotate = 90.degrees
      t = Geom::Transformation.rotation(target_point, vector, degrees_to_rotate)
      transformation = Geom::Transformation.new([(bx * @unit) + w, by * @unit, @height]) * t
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
    end

    def self.add_kiln_layer
      layer_name = "Kiln#{@index}"
      @index += 1
      model = Sketchup.active_model
      model.layers.add(layer_name) unless model.layers[layer_name]
      @layer = model.layers[layer_name]
    end

    def self.create_slab
      add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Slab')
      transformation = Geom::Transformation.new([0, 0, @height])
      componentinstance = entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      @height += componentdefinition.bounds.depth
    end

    def self.create_concrete_block_base
      add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Cinder Block')
      l = componentdefinition.bounds.height
      w = componentdefinition.bounds.width
      5.times do |i|
        11.times do |j|
          transformation = Geom::Transformation.new([i * (w + (5.0 / 4.0)), j * (l + (4.0 / 10.0)), @height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = @layer
        end
      end
      @height += componentdefinition.bounds.depth
    end

    def self.create_ifb_floor
      add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('IFB')
      # have to swap l & w because of the rotation applied
      l = componentdefinition.bounds.width
      w = componentdefinition.bounds.height
      target_point = Geom::Point3d.new(0, 0, 0)
      vector = Geom::Vector3d.new(0, 0, 1)
      degrees_to_rotate = 90.degrees
      t = Geom::Transformation.rotation(target_point, vector, degrees_to_rotate)
      5.times do |i|
        40.times do |j|
          transformation = Geom::Transformation.new([(i * w) + w, j * l, @height]) * t
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = @layer
        end
      end
      @height += componentdefinition.bounds.depth
    end

    def self.create_fb_tile_floor
      add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Floor Tile')
      l = componentdefinition.bounds.height
      w = componentdefinition.bounds.width
      5.times do |i|
        20.times do |j|
          transformation = Geom::Transformation.new([i * w, j * l, @height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = @layer
        end
      end
      @height += componentdefinition.bounds.depth
    end

    def self.create_brick(l, w, h, name, material)
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = material
      group = compdefinition.entities.add_group
      face = group.entities.add_face [0, 0, 0], [w, 0, 0], [w, l, 0], [0, l, 0]
      face.pushpull(-h)
    end

    def self.create_components
      l = 9.0
      w = 4.5
      h = 2.5
      create_brick(l, w, h, 'FB', 'Goldenrod')
      create_brick(l, l, h, 'Floor Tile', 'DarkGoldenrod')
      create_brick(l, w, h, 'IFB', 'Cornsilk')
      create_brick(l / 2, w, h, 'FB/2', 'Goldenrod')
      create_brick(l / 2, w, h, 'IFB/2', 'Cornsilk')
      create_brick(l / 4, w, h, 'FB/4', 'Goldenrod')
      create_brick(l / 4, w, h, 'IFB/4', 'Cornsilk')
      create_brick(16.0, 8.0, 8.0, 'Cinder Block', 'SlateGray')
      create_brick(180.0, 45.0, 3.5, 'Slab', 'LightSlateGray')
    end

    def self.find_componentdefinition(name)
      model = Sketchup.active_model
      defs  = model.definitions
      defs.each do |defn|
        # skip all those in use
        return defn if name == defn.name
      end
    end

    def self.reload_files
      original_verbose = $VERBOSE
      $VERBOSE = nil
      pattern = File.join(__dir__, '**/*.rb')
      Dir.glob(pattern).each do |file|
        # Cannot use `Sketchup.load` because its an alias for `Sketchup.require`.
        load file
      end.size
    ensure
      $VERBOSE = original_verbose
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Create Kiln') do
        create_components
        create_kiln
      end

      file_loaded(__FILE__)
    end
  end
end
