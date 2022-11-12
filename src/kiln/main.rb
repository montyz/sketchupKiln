require "sketchup.rb"

# Monty::KilnTool.reloadFiles
module Monty
  module KilnTool

    def self.create_kiln
      l = 9
      w = 4.5
      h = 2.5  
      n = 5
      s = 10
      model = Sketchup.active_model
      entities = model.entities
      model.start_operation("Create Kiln", true)
      componentdefinition = self.find_componentdefinition("Standard Firebrick")
      (0..n).each { |i|
          (0..n).each { |j|
              (0..n).each { |k|
                  transformation = Geom::Transformation.new([i*w,j*l,k*h])
                  componentinstance = entities.add_instance(componentdefinition, transformation)
                  componentinstance.material = componentdefinition.material
              }
          }
      }
      model.commit_operation
    end

    def self.create_brick(l, w, h, name, material)
      model = Sketchup.active_model
      entities = model.entities
      definitions=model.definitions
      compdefinition=definitions.add name
      compdefinition.material = material
      group = compdefinition.entities.add_group
      face = group.entities.add_face [0,0,0],[w,0,0],[w,l,0],[0,l,0]
      face.pushpull -h
      # component = group.to_component
      # component.material = compdefinition.material
      # component
    end

    def self.create_bricks
      l = 9
      w = 4.5
      h = 2.5  
      component = self.create_brick(l, w, h, "Standard Firebrick", "Goldenrod")
    end

    def self.find_componentdefinition(name)
      model = Sketchup.active_model
      defs  = model.definitions
      defs.each do |defn|
        # skip all those in use
         if (name == defn.name)
           return defn
         end
       end
    end

    def self.reloadFiles
      original_verbose = $VERBOSE
      $VERBOSE = nil
      pattern = File.join(__dir__, "**/*.rb")
      Dir.glob(pattern).each { |file|
        # Cannot use `Sketchup.load` because its an alias for `Sketchup.require`.
        load file
      }.size
    ensure
      $VERBOSE = original_verbose
    end
  
    unless file_loaded?(__FILE__)
      menu = UI.menu("Plugins")
      menu.add_item("Create Kiln") {
        self.create_bricks
        self.create_kiln
      }

      file_loaded(__FILE__)
    end
  end # module HelloCube
end # module Examples
