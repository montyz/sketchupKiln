require 'sketchup'

# √ how to get bounding box l,w,h
# √ how to rotate component (Geom.Transformation.something...)
# √ how to tweak rubocop to not complain about 15 line methods
# √ create a layer and assign a course to it Layout::Layer ? or Layout::Label
# √ iterate over all instances and sum by type
# X how to define my own units?
# X how to create ruby DSL?
# use the oversize bricks in header courses
# use 2" slabs & squares in air intake
# use 2" slabs & squares over door arches?
# course a
# course b
# header course
# bagwall & primary air
# arches
# build the cast headers

# to reload from Sketchup Ruby Console:
# Monty::KilnTool.reload_files
module Monty
  # Kiln builder
  module KilnTool
    @index = -1
    @serial = 0
    @sub = ''
    @height = -3.5
    @unit = 4.5
    @layer = nil
    @layer_name = ''
    def self.create_kiln
      model = Sketchup.active_model
      model.start_operation('Create Kiln', true)
      create_slab
      create_concrete_block_base
      create_ifb_floor
      create_fb_tile_floor
      create_brick_row4
      create_brick_row5
      create_brick_row6
      create_brick_row7
      create_brick_row8
      create_brick_row9
      create_brick_row10
      model.commit_operation
      hash = {}
      Sketchup.active_model.entities.each do |instance|
        hash[instance.definition.name] = hash.key?(instance.definition.name) ? hash[instance.definition.name] + 1 : 1
      end
      hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def self.create_brick_row10
      # header course
      add_kiln_layer
      lay_bagwall_a_header_course
      3.times do |i|
        lay_brick('IFB', 0, (i * 2))
      end
      2.times do |i|
        lay_brick('LG', 1, i * 2)
      end
      lay_brick('FB/2', 1, 4)
      lay_brick('FB', 1, 5)
      2.times do |i|
        lay_brick_rotated('LG', 2.5, i * 1.5)
        lay_brick_rotated('LG', 5.5, i * 1.5)
      end

      2.times do |i|
        lay_brick('FB', 4.5, i * 2)
      end

      lay_brick('LG', 7.5, 0)
      lay_brick('LG', 7.5, 2)
      # col 8
      lay_brick('FB/2', 8, 4)
      lay_brick('FB', 8, 5)

      # col 9
      3.times do |i|
        lay_brick('IFB', 9, (i * 2))
      end
      @height += 2.5
    end

    def self.create_brick_row9
      add_kiln_layer
      lay_bagwall_b
      # col 0
      bx = 0
      by = 0
      lay_brick_rotated('IFB', bx, by)
      2.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end
      # col 1
      bx += 1
      by = 1
      lay_brick('FB/2', bx, by)
      by += 1
      lay_brick('FB', bx, by)
      by += 2
      lay_brick('FB', bx, by)
      # col 2
      bx += 1
      by = 0
      lay_brick('FB', bx, by)
      # col 3
      lay_brick('FB/2', 2, 2)
      # col 4
      bx = 4
      2.times do |i|
        lay_brick_rotated('LG', bx, by + (i * 1.5))
      end
      # col 7
      bx = 7
      lay_brick('FB', bx, by)
      by += 2
      lay_brick('FB/2', bx, by)
      # col 8
      bx = 8
      lay_brick_rotated('IFB', bx, 0)
      lay_brick('FB/2', bx, 1)
      lay_brick('FB', bx, 2)
      lay_brick('FB', bx, 4)
      # col 9
      bx = 9
      2.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end

      @height += 2.5
    end

    def self.create_brick_row8
      add_kiln_layer
      lay_bagwall_a
      3.times do |i|
        lay_brick('IFB', 0, (i * 2))
      end
      2.times do |i|
        lay_brick('LG', 1, i * 2)
      end
      lay_brick('FB/2', 1, 4)
      lay_brick('FB', 1, 5)
      3.times do |i|
        lay_brick_rotated('LG', 2.5, i * 1.5)
        lay_brick_rotated('LG', 5.5, i * 1.5)
      end

      2.times do |i|
        lay_brick('FB', 4.5, i * 2)
      end

      lay_brick('LG', 7.5, 0)
      lay_brick('LG', 7.5, 2)
      # col 8
      lay_brick_rotated('LG', 8, 4)
      # col 9
      2.times do |i|
        lay_brick('IFB', 9, (i * 2))
      end
      lay_brick('LFB', 8, 5.5)
      lay_brick('LFB', 9, 5.5)
      @height += 2.5
    end

    def self.create_brick_row7
      add_kiln_layer
      lay_bagwall_b

      # col 0
      bx = 0
      by = 0
      lay_brick_rotated('IFB', bx, by)
      2.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end
      # col 1
      bx += 1
      lay_brick('IFB/2', bx, 1)
      by += 2
      2.times do |i|
        lay_brick_rotated('LG', bx, (i * 1.5) + by)
      end
      lay_brick('FB/2', 1, 5)
      # col 2
      bx += 1
      by = 0
      lay_brick('FB', bx, by)
      # col 4
      bx = 4
      3.times do |i|
        lay_brick_rotated('LG', bx, by + (i * 1.5))
      end
      # col 7
      bx = 7
      lay_brick('FB', bx, by)
      by += 2
      2.times do |i|
        lay_brick_rotated('LG', bx, (i * 1.5) + by)
      end
      # col 8
      bx = 8
      lay_brick_rotated('IFB', bx, 0)
      lay_brick('IFB/2', bx, 1)
      lay_brick_rotated('FB', bx, 5)
      # col 9
      bx = 9
      2.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end

      @height += 2.5
    end

    def self.create_brick_row4
      add_kiln_layer
      # col 0
      bx = 0
      by = 0
      19.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      # col 1
      bx += 1
      lay_brick('IFB', bx, by)
      by += 2
      lay_brick_rotated('FB', bx, by)
      by += 1
      2.times do |i|
        lay_brick_rotated('LG', bx, (i * 1.5) + by)
      end
      # col 2
      bx += 1
      by = 0
      lay_brick('FB', bx, by)
      lay_bagwall_a
      # col 3
      bx += 1
      # col 4
      bx += 1
      4.times do |i|
        lay_brick_rotated('LG', bx, by + (i * 1.5))
      end
      # col 5
      bx += 1
      # col 6
      bx += 1
      # col 7
      bx += 1
      lay_brick('FB', bx, by)
      by += 2
      lay_brick_rotated('FB', bx, by)
      by += 1
      2.times do |i|
        lay_brick_rotated('LG', bx, (i * 1.5) + by)
      end
      # col 8
      bx += 1
      by = 0
      lay_brick('IFB', bx, by)
      by = 8
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
      7.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      @height += 2.5
    end

    def self.create_brick_row5
      add_kiln_layer
      lay_bagwall_b
      bx = 0
      by = 0
      lay_brick_rotated('IFB', 0, 0)
      lay_brick_rotated('IFB', 8, 0)
      3.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      2.times do |i|
        lay_brick('IFB', 9, 1 + (i * 2))
      end
      lay_brick('FB', 2, 0)
      lay_brick('FB', 7, 0)
      lay_brick('FB/2', 1, 1)
      lay_brick('FB/2', 8, 1)
      2.times do |i|
        lay_brick_rotated('LG', 1, 2 + (i * 1.5))
        lay_brick_rotated('LG', 7, 2 + (i * 1.5))
      end
      lay_brick_rotated('FB', 1, 5)
      lay_brick('FB/2', 7, 5)
      lay_brick_rotated('FB', 8, 5)
      4.times do |i|
        lay_brick_rotated('LG', 4, i * 1.5)
      end

      @height += 2.5
    end

    def self.create_brick_row6
      add_kiln_layer
      lay_bagwall_a
      bx = 0
      by = 0
      3.times do |i|
        lay_brick('IFB', 0, (i * 2))
      end
      3.times do |i|
        lay_brick('LG', 1, i * 2)
      end
      4.times do |i|
        lay_brick_rotated('LG', 2.5, i * 1.5)
        lay_brick_rotated('LG', 5.5, i * 1.5)
      end

      3.times do |i|
        lay_brick('FB', 4.5, i * 2)
      end

      lay_brick('LG', 7.5, 0)
      lay_brick('LG', 7.5, 2)
      lay_brick('FB', 7.5, 4)
      lay_brick('LG', 8.5, 4)
      2.times do |i|
        lay_brick('IFB', 9, (i * 2))
      end

      @height += 2.5
    end

    def self.lay_bagwall_b
      @sub = 'lay_bagwall_b'
      lay_brick_rotated('LG', 1, 29)
      lay_brick_rotated('LG', 3, 29)
      lay_brick_rotated('LG', 5, 29)
      lay_brick_rotated('LG', 7, 29)
      lay_brick_rotated('LG', 1, 30.5)
      lay_brick_rotated('LG', 3, 30.5)
      lay_brick_rotated('LG', 5, 30.5)
      lay_brick_rotated('LG', 7, 30.5)
      3.times do |i|
        lay_brick('FB', 1, (i * 2) + 32)
        lay_brick('FB', 8, (i * 2) + 32)
      end
      @sub = ''
    end

    def self.lay_bagwall_a
      @sub = 'lay_bagwall_a'
      lay_brick('FB', 1, 28)
      lay_brick('FB/2', 1, 30)
      3.times do |i|
        lay_brick('FB', 1, (i * 2) + 31)
      end
      lay_brick('FB', 2.5, 29)
      lay_brick('FB/2', 2.5, 31)
      lay_brick('FB', 4.5, 29)
      lay_brick('FB/2', 4.5, 31)
      lay_brick('FB', 6.5, 29)
      lay_brick('FB/2', 6.5, 31)
      lay_brick('FB', 8, 28)
      lay_brick('FB/2', 8, 30)
      3.times do |i|
        lay_brick('FB', 8, (i * 2) + 31)
      end
      @sub = ''
    end

    def self.lay_bagwall_a_header_course
      @sub = 'lay_bagwall_a_header'
      5.times do |i|
        lay_brick_rotated('LG', 0, 28 + (i * 1.5))
        lay_brick_rotated('LG', 8, 28 + (i * 1.5))
      end

      lay_brick('FB', 2.5, 29)
      lay_brick('FB/2', 2.5, 31)
      lay_brick('FB', 4.5, 29)
      lay_brick('FB/2', 4.5, 31)
      lay_brick('FB', 6.5, 29)
      lay_brick('FB/2', 6.5, 31)
      @sub = ''
    end

    def self.lay_brick(brick_type, bx, by)
      componentdefinition = find_componentdefinition(brick_type)
      transformation = Geom::Transformation.new([bx * @unit, by * @unit, @height])
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      assign_instance_name componentinstance
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
      assign_instance_name componentinstance
    end

    def self.assign_instance_name(componentinstance)
      componentinstance.name = "#{@layer_name} #{@sub} #{@serial}"
      @serial += 1
    end

    def self.add_kiln_layer
      @index += 1
      formatted = format('%02d', @index)
      @layer_name = "Kiln#{formatted}"
      @serial = 0
      model = Sketchup.active_model
      model.layers.add(@layer_name) unless model.layers[@layer_name]
      @layer = model.layers[@layer_name]
    end

    def self.create_slab
      add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Slab')
      transformation = Geom::Transformation.new([0, 0, @height])
      componentinstance = entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      assign_instance_name componentinstance
      @height += componentdefinition.bounds.depth
    end

    def self.create_concrete_block_base
      add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Cinder Block')
      l = componentdefinition.bounds.height
      w = componentdefinition.bounds.width
      5.times do |i|
        10.times do |j|
          transformation = Geom::Transformation.new([i * (w + (5.0 / 4.0)), j * (l + (11.0 / 9.0)), @height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = @layer
          assign_instance_name componentinstance
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
        38.times do |j|
          transformation = Geom::Transformation.new([(i * w) + w, j * l, @height]) * t
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = @layer
          assign_instance_name componentinstance
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
        19.times do |j|
          transformation = Geom::Transformation.new([i * w, j * l, @height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = @layer
          assign_instance_name componentinstance
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
      create_brick(13.5, w, h, 'LFB', 'BurlyWood')
      create_brick(l, 6.75, h, 'LG', 'Khaki')
      create_brick(l / 2, w, h, 'FB/2', 'Goldenrod')
      create_brick(l / 2, w, h, 'IFB/2', 'Cornsilk')
      create_brick(l / 4, w, h, 'FB/4', 'Goldenrod')
      create_brick(l / 4, w, h, 'IFB/4', 'Cornsilk')
      create_brick(16.0, 8.0, 8.0, 'Cinder Block', 'SlateGray')
      create_brick(171.0, 45.0, 3.5, 'Slab', 'LightSlateGray')
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
