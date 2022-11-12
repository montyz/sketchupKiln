require 'sketchup'

# Monty::KilnTool.reload_files
module Monty
  module KilnTool
    def self.create_kiln
      height = 0
      model = Sketchup.active_model
      model.start_operation('Create Kiln', true)
      height += create_slab height
      height += create_concrete_block_base height
      height += create_ifb_floor height
      model.commit_operation
    end

    def self.create_slab(height)
      model = Sketchup.active_model
      entities = model.entities
      componentdefinition = find_componentdefinition('Slab')
      transformation = Geom::Transformation.new([-1.5, 0, height])
      componentinstance = entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      3.5
    end

    def self.create_concrete_block_base(height)
      l = 16.0
      w = 8.0
      model = Sketchup.active_model
      entities = model.entities
      componentdefinition = find_componentdefinition('Cinder Block')
      6.times do |i|
        10.times do |j|
          transformation = Geom::Transformation.new([i * w - 1.5, j * (l + 11.0 / 9.0), height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
        end
      end
      8
    end

    def self.create_ifb_floor(height)
      l = 9.0
      w = 4.5
      model = Sketchup.active_model
      entities = model.entities
      componentdefinition = find_componentdefinition('IFB')
      10.times do |i|
        19.times do |j|
          transformation = Geom::Transformation.new([i * w, j * l, height])
          componentinstance = entities.add_instance(componentdefinition, transformation)
          componentinstance.material = componentdefinition.material
        end
      end
      2.5
    end

    def self.create_brick(l, w, h, name, material)
      model = Sketchup.active_model
      definitions = model.definitions
      compdefinition = definitions.add name
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
      create_brick(171.0, 48.0, 3.5, 'Slab', 'LightSlateGray')
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
