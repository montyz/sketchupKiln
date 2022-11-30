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
    def self.create_kiln
      model = Sketchup.active_model
      model.start_operation('Create Kiln', true)
      create_slab
      create_concrete_block_base
      create_ifb_floor
      create_fb_floor
      model.commit_operation
      hash = {}
      Sketchup.active_model.entities.each do |instance|
        hash[instance.definition.name] = hash.key?(instance.definition.name) ? hash[instance.definition.name] + 1 : 1
      end
      hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def self.add_kiln_layer
      layer_name = "Kiln#{@index}"
      @index += 1
      model = Sketchup.active_model
      model.layers.add(layer_name) unless model.layers[layer_name]
      model.layers[layer_name]
    end

    def self.create_slab
      layer = add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Slab')
      transformation = Geom::Transformation.new([0, 0, @height])
      componentinstance = entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = layer
      @height += componentdefinition.bounds.depth
    end

    def self.create_concrete_block_base
      layer = add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('Cinder Block')
      l = componentdefinition.bounds.height
      w = componentdefinition.bounds.width
      5.times do |i|
        10.times do |j|
          transformation = Geom::Transformation.new([i * (w + (5.0 / 4.0)), j * (l + (11.0 / 9.0)), @height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = layer
        end
      end
      @height += componentdefinition.bounds.depth
    end

    def self.create_ifb_floor
      layer = add_kiln_layer
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
          componentinstance.layer = layer
        end
      end
      @height += componentdefinition.bounds.depth
    end

    def self.create_fb_floor
      layer = add_kiln_layer
      entities = Sketchup.active_model.entities
      componentdefinition = find_componentdefinition('FB')
      l = componentdefinition.bounds.height
      w = componentdefinition.bounds.width
      10.times do |i|
        19.times do |j|
          transformation = Geom::Transformation.new([i * w, j * l, @height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
          componentinstance.layer = layer
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
      create_brick(l, w, h, 'IFB', 'Cornsilk')
      create_brick(l / 2, w, h, 'FB/2', 'Goldenrod')
      create_brick(l / 2, w, h, 'IFB/2', 'Cornsilk')
      create_brick(l / 4, w, h, 'FB/4', 'Goldenrod')
      create_brick(l / 4, w, h, 'IFB/4', 'Cornsilk')
      create_brick(16.0, 8.0, 8.0, 'Cinder Block', 'LightSlateGray')
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
