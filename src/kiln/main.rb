require "sketchup.rb"

module Monty
  module KilnTool
    def self.create_brick
      l = 9
      w = 4.5
      h = 2.5
      n = 3
      s = 10
      model = Sketchup.active_model
      model.start_operation("Create Kiln", true)
      entities = model.entities
      definitions=model.definitions
      compdefinition=definitions.add "Block"
      group = compdefinition.entities.add_group
      face = group.entities.add_face [0,0,0],[l,0,0],[l,w,0],[0,w,0]
      face.pushpull -h
      component = group.to_component
      (0..n).each { |i|
          (0..n).each { |j|
              (0..n).each { |k|
                  transformation = Geom::Transformation.new([i*l,j*w,k*h])
                  componentinstance = entities.add_instance(component.definition, transformation)
              }
          }
      }
      model.commit_operation
    end

    unless file_loaded?(__FILE__)
      menu = UI.menu("Plugins")
      menu.add_item("Create Kiln") {
        self.create_brick
      }

      file_loaded(__FILE__)
    end
  end # module HelloCube
end # module Examples
