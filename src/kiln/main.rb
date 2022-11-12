require 'sketchup.rb'

module Monty
  module KilnTool

def self.create_cube
  model = Sketchup.active_model
  model.start_operation('Create Kiln', true)
  group = model.active_entities.add_group
  entities = group.entities
  points = [
    Geom::Point3d.new(0,   0,   0),
    Geom::Point3d.new(1.m, 0,   0),
    Geom::Point3d.new(1.m, 1.m, 0),
    Geom::Point3d.new(0,   1.m, 0)
  ]
  face = entities.add_face(points)
  face.pushpull(-1.m)
  model.commit_operation
end

unless file_loaded?(__FILE__)
  menu = UI.menu('Plugins')
  menu.add_item('Create Kiln') {
    self.create_cube
  }

  file_loaded(__FILE__)
end

  end # module HelloCube
end # module Examples
