require "sketchup.rb"
require "extensions.rb"

module Monty
  module KilnTool
    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new("Kiln Tool", "kiln/main")
      ex.description = "Make the kiln."
      ex.version = "1.0.0"
      ex.copyright = "Monty Zukowski © 2022"
      ex.creator = "Monty"
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end
  end
end
