require 'sketchup'

# √ how to get bounding box l,w,h
# √ how to rotate component (Geom.Transformation.something...)
# √ how to tweak rubocop to not complain about 15 line methods
# √ create a layer and assign a course to it Layout::Layer ? or Layout::Label
# √ iterate over all instances and sum by type
# X how to define my own units?
# X how to create ruby DSL?
# √ use the oversize bricks in header courses
# **** leave 8" spaces between shelves under stoke holes ****
# use 2" slabs & squares in air intake
# use 2" slabs & squares over door arches?
# course a
# course b
# header course
# bagwall & primary air
# arches
# build the cast headers

# to install for sketchup:
# ln -s /Users/monty/code/sketchupKiln/src/kiln.rb '/Users/monty/Library/Application Support/SketchUp 2017/SketchUp/Plugins/kiln.rb'
# ln -s /Users/monty/code/sketchupKiln/src/kiln '/Users/monty/Library/Application Support/SketchUp 2017/SketchUp/Plugins/kiln'

# to reload from Sketchup Ruby Console:
# Monty::KilnTool.reload_files
module Monty
  # Kiln builder
  module KilnTool
    @index = -1
    @serial = 0
    @grid = 'unk'
    @sub = ''
    @height = -3.5
    @unit = 4.5
    @layer = nil
    @layer_name = ''
    @a27_center = [0, 0, -47.599]
    @a27_angle = 0.278
    @arch_xaxis = [0, 0, 1]
    @arch_vector = Geom::Vector3d.new 0, 1, 0
    @arch_normal = @arch_vector.normalize!
    @a18_center = [0, 0, -48.566]
    @a18_angle = 0.195

    def self.reject_coordinates(bx, by)
      # return true if bx >= 7
      # return true if bx <= 2
      # return true if by < 26
      return true if @height / 2.5 > 7
      # return true if @height / 2.5 != 6

      false
    end

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
      create_brick_row11
      create_brick_row12
      create_brick_row13
      create_brick_row14
      create_brick_row15
      create_brick_row16
      create_brick_row17
      create_brick_row18
      create_brick_row19
      create_brick_row20
      create_brick_row21
      create_brick_row22
      create_brick_row23
      create_brick_row24
      create_brick_row25
      create_brick_row26
      create_brick_row27
      create_brick_row28
      create_brick_row29
      create_brick_row30
      create_brick_row31
      15.times do
        add_kiln_layer
        chimney_course_b
        @height += 2.5
        add_kiln_layer
        chimney_course_a
        @height += 2.5
      end

      model.commit_operation
      hash = {}
      Sketchup.active_model.entities.each do |instance|
        hash[instance.definition.name] = hash.key?(instance.definition.name) ? hash[instance.definition.name] + 1 : 1
      end
      hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def self.create_brick_row31
      add_kiln_layer
      6.times do |i|
        lay_brick_rotated('arch1_27', 2 + i, 5)
      end
      5.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      4.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
      end
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 0)
        lay_brick_rotated('IFB', 1 + (i * 2), 9)
      end
      11.times do |i|
        lay_brick_rotated('Skew', 2 + (i * 2.5 / 4.5), 1, 90.degrees)
        lay_brick_rotated('Skew', 1.5 + (i * 2.5 / 4.5), 9, 270.degrees)
      end
      chimney_course_a
      @height += 2.5
    end

    def self.create_brick_row30
      add_kiln_layer
      create_brick_row22_bourry_box(include_door=false, span_over_door=true)
      chimney_course_a
      @height += 2.5
    end

    def self.create_brick_row29
      add_kiln_layer
      create_brick_row21_bourry_box(include_door=false, span_over_door=true)
      chimney_course_b
      @height += 2.5
    end

    def self.create_brick_row28
      add_kiln_layer
      create_brick_row22_bourry_box(include_door=false)
      chimney_course_a
      @height += 2.5
    end

    def self.create_brick_row27
      add_kiln_layer
      create_brick_row21_bourry_box(include_door=false)
      chimney_course_b
      @height += 2.5
    end

    def self.create_brick_row26
      add_kiln_layer
      10.times do |i|
        lay_brick_rotated('FB', 0, i)
      end
      2.times do |i|
        lay_brick_rotated('FB', 8, i)
        lay_brick_rotated('FB', 8, 8 + i)
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 0)
        lay_brick_rotated('FB', 2 + (i * 2), 1)
      end
      6.times do |i|
        lay_brick('FB', 2 + i, 8)
      end
      lay_brick_rotated('arch2_18', 8, 5)
      lay_brick_rotated('arch2_18', 9, 5)
      3.times do |i|
        lay_brick_rotated('Skew', 8 + (i * 2.5 / 4.5), 2, 90.degrees)
        lay_brick_rotated('Skew', 7.5 + (i * 2.5 / 4.5), 8, 270.degrees)
      end
      chimney_course_a
      @height += 2.5
    end

    def self.create_brick_row25
      add_kiln_layer
      create_brick_row21_bourry_box
      # chimney with peep
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 31.625)
      end
      2.times do |i|
        lay_brick('FB', 1, 31.625 + (i * 2))
        lay_brick('FB', 8, 31.625 + (i * 2))
      end
      lay_brick_rotated('FB', 1 , 35.625)
      lay_brick_rotated('FB3/4', 3 , 35.625)
      lay_brick_rotated('FB3/4', 5.5 , 35.625)
      lay_brick_rotated('FB', 7, 35.625)

      @height += 2.5
    end

    def self.create_brick_row24
      add_kiln_layer
      create_brick_row22_bourry_box
      # chimney with peep
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 31.625)
      end
      2.times do |i|
        lay_brick('FB', 1, 32.625 + (i * 2))
        lay_brick('FB', 8, 32.625 + (i * 2))
      end
      lay_brick_rotated('FB', 2, 35.625)
      lay_brick_rotated('FB/4', 4, 35.625)
      lay_brick_rotated('FB/4', 5.5, 35.625)
      lay_brick_rotated('FB', 6, 35.625)
      @height += 2.5
    end

    def self.create_brick_row23
      add_kiln_layer
      create_brick_row21_bourry_box
      chimney_course_b
      @height += 2.5
    end

    def self.create_brick_row22_bourry_box(include_door = true, span_over_door = false)
      5.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      4.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 0)
        lay_brick_rotated('FB', 2 + (i * 2), 1)
        lay_brick_rotated('FB', 2 + (i * 2), 8)
      end
      lay_brick_rotated('IFB/2', 1, 0)
      lay_brick_rotated('IFB/2', 8, 0)
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 9)
      end
      lay_brick('IFB', 9, 0)
      lay_brick('IFB', 9, 8)
      lay_brick('FB/2', 8, 1)
      lay_brick('FB/2', 8, 8)
      if include_door
        lay_brick_rotated('FB', 8, 2)
        lay_brick_rotated('FB', 8, 7)
      end
    end

    def self.create_brick_row22
      add_kiln_layer
      create_brick_row22_bourry_box
      chimney_course_a
      @height += 2.5
    end

    def self.chimney_course_a
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 31.625)
      end
      2.times do |i|
        lay_brick('FB', 1, 32.625 + (i * 2))
        lay_brick('FB', 8, 32.625 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 35.625)
      end
    end

    def self.chimney_course_b
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 31.625)
      end
      2.times do |i|
        lay_brick('FB', 1, 31.625 + (i * 2))
        lay_brick('FB', 8, 31.625 + (i * 2))
      end
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 35.625)
      end
    end

    def self.create_brick_row21_bourry_box(include_door = true, span_over_door = false)
      4.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      5.times do |i|
        lay_brick_rotated('IFB', i * 2, 9)
      end
      3.times do |i|
        lay_brick('FB', 1, 2 + (i * 2))
      end
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 8)
      end
      lay_brick_rotated('IFB', 0, 0)
      lay_brick_rotated('IFB', 8, 0)
      lay_brick_rotated('FB/4', 2, 0)
      lay_brick_rotated('FB3/4', 1, 1)
      lay_brick_rotated('FB/2', 3.5, 0)
      lay_brick_rotated('FB/2', 5.5, 0)
      lay_brick_rotated('FB/2', 3.5, 1)
      lay_brick_rotated('FB/2', 5.5, 1)
      lay_brick_rotated('FB/4', 7.5, 0)
      lay_brick_rotated('FB3/4', 7.5, 1)
      if span_over_door
        4.times do |i|
          lay_brick('IFB', 9, 1 + (i * 2))
        end
      else
        lay_brick('IFB/2', 9, 1)
        lay_brick('IFB/2', 9, 8)
      end
      if include_door
        lay_brick_rotated('FB', 8, 2)
        lay_brick_rotated('FB', 8, 7)
      end
    end

    def self.create_brick_row21
      add_kiln_layer
      create_brick_row21_bourry_box
      # chimney
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 31.625)
      end
      lay_brick('FB/2', 1, 31.625)
      lay_brick('FB/2', 8, 31.625)
      8.times do |i|
        lay_brick('FB', 1 + i, 35.625)
      end
      lay_brick('LFB', 1, 32.625)
      lay_brick('LFB', 8, 32.625)
      @height += 2.5
    end

    def self.create_brick_row20
      add_kiln_layer
      5.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      4.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 1)
        lay_brick_rotated('FB', 2 + (i * 2), 8)
      end
      lay_brick_rotated('FB', 1, 0)
      lay_brick_rotated('FB', 3, 0)
      lay_brick_rotated('FB', 5, 0)
      lay_brick_rotated('FB', 7, 0)
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 9)
      end
      lay_brick('IFB', 9, 0)
      6.times do |i|
        lay_brick_rotated('FB', 8, 2 + i)
      end
      lay_brick('IFB', 9, 8)
      lay_brick('FB/2', 8, 1)
      lay_brick('FB/2', 8, 8)
      # chimney
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 31.75)
      end
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 35.5)
        lay_brick_rotated('FB', 1 + (i * 2), 36.5)
      end

      @height += 2.5
    end

    def self.create_brick_row19
      add_kiln_layer
      15.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      4.times do |i|
        lay_brick('IFB', 9, 1 + (i * 2))
      end
      11.times do |i|
        lay_brick('IFB', 9, 9 + (i * 2))
      end
      lay_brick_rotated('IFB', 0, 0)
      lay_brick_rotated('FB3/4', 2, 0)
      lay_brick_rotated('FB', 4, 0)
      lay_brick_rotated('FB3/4', 6.5, 0)
      lay_brick_rotated('IFB', 8, 0)
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 9)
      end
      lay_brick_rotated('FB/4', 1, 1)
      lay_brick_rotated('FB', 1.5, 1)
      lay_brick_rotated('FB', 4, 1)
      lay_brick_rotated('FB', 6.5, 1)
      lay_brick_rotated('FB/4', 8.5, 1)
      lay_brick_rotated('FB/4', 1, 8)
      lay_brick_rotated('FB', 1.5, 8)
      lay_brick_rotated('FB', 4, 8)
      lay_brick_rotated('FB', 6.5, 8)
      lay_brick_rotated('FB/4', 8.5, 8)
      3.times do |i|
        lay_brick('LG', 1, 2 + (i * 2))
        lay_brick('LG', 7.5, 2 + (i * 2))
      end
      lay_brick('Rod', 4, 0)
      lay_brick('Rod', 6.5, 0)
      # chimney
      lay_brick('FB/2', 0, 31)
      lay_brick('FB/2', 9, 31)
      3.times do |i|
        lay_brick('FB', 0, 32 + (i * 2))
        lay_brick('FB', 9, 32 + (i * 2))
      end
      3.times do |i|
        lay_brick('FB', 1, 31.5 + (i * 2))
        lay_brick('FB', 8, 31.5 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 31.5)
      end
      6.times do |i|
        lay_brick('FB', 2 + i, 35.5)
      end
      @height += 2.5
    end

    def self.create_brick_row18
      add_kiln_layer
      lay_brick_rotated('IFB', 1, 0)
      lay_brick_rotated('FB', 3, 0)
      lay_brick_rotated('FB', 5, 0)
      lay_brick_rotated('IFB', 7, 0)
      15.times do |i|
        lay_brick('IFB', 0, i * 2)
        lay_brick('IFB', 9, i * 2)
      end
      lay_brick('IFB/2', 0, 30)
      lay_brick('IFB/2', 9, 30)
      3.times do |i|
        lay_brick('IFB', 0, 31 + (i * 2))
        lay_brick('IFB', 9, 31 + (i * 2))
      end
      5.times do |i|
        lay_brick_rotated('IFB', i * 2, 37)
      end
      4.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
        lay_brick('FB', 8, 1 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 1)
        lay_brick_rotated('FB', 2 + (i * 2), 8)
      end
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 9)
      end
      2.times do |i|
        lay_brick('FB', 1, 32 + (i * 2))
        lay_brick('FB', 8, 32 + (i * 2))
      end
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 31)
        lay_brick_rotated('FB', 1 + (i * 2), 36)
      end
      8.times do |i|
        lay_brick('FB', 1 + i, 29)
      end
      19.times do |i|
        lay_brick('arch1_27', 5, 10 + i)
      end
      34.times do |i|
        lay_brick('Skew', 1, 10 + (i * 2.5 / 4.5))
        lay_brick_rotated('Skew', 8.445, 10.666 + (i * 2.5 / 4.5), 180.degrees)
      end
      @height += 2.5
    end

    def self.create_brick_row17
      add_kiln_layer
      lay_bagwall_b(include_chimney = false)
      3.times do |i|
        lay_brick('LG', i * 1.5, 0)
      end
      lay_brick('FB', 4.5, 0)
      3.times do |i|
        lay_brick('LG', 5.5 + (i * 1.5), 0)
      end
      4.times do |i|
        lay_brick_rotated('LG', 0, 2 + (i * 1.5))
        lay_brick_rotated('LG', 8, 2 + (i * 1.5))
      end
      lay_brick('IFB', 0, 8)
      lay_brick('IFB', 9, 8)
      12.times do |i|
        lay_brick_rotated('LG', 0, 10 + (i * 1.5))
        lay_brick_rotated('LG', 8, 10 + (i * 1.5))
      end
      lay_brick_rotated('FB', 0, 28)
      lay_brick_rotated('FB', 8, 28)
      lay_brick('IFB', 0, 29)
      lay_brick('IFB/2', 0, 31)
      lay_brick('IFB', 9, 29)
      lay_brick('IFB/2', 9, 31)
      4.times do |i|
        lay_brick_rotated('LG', 0, 32 + (i * 1.5))
        lay_brick_rotated('LG', 8, 32 + (i * 1.5))
      end
      4.times do |i|
        lay_brick('LG', 2 + (i * 1.5), 36)
      end

      @height += 2.5
    end

    def self.create_brick_row16
      add_kiln_layer
      lay_bagwall_a
      5.times do |i|
        lay_brick_rotated('IFB', i * 2, 0)
      end
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 1)
      end
      7.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      lay_brick('IFB/2', 0, 15)
      3.times do |i|
        lay_brick('FB', 1, 2 + (i * 2))
      end
      3.times do |i|
        lay_brick('FB', 1, 10 + (i * 2))
      end
      2.times do |i|
        lay_brick('FB', 0, 24 + (i * 2))
      end
      5.times do |i|
        lay_brick('IFB', 0, 28 + (i * 2))
      end
      lay_brick('FB/2', 1, 24)
      2.times do |i|
        lay_brick('FB', 1, 25 + (i * 2))
      end
      lay_peeps_c(false)
      3.times do |i|
        lay_brick('FB', 8, 2 + (i * 2))
      end
      lay_brick('FB/2', 8, 10)
      5.times do |i|
        lay_brick('IFB', 9, 1 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 36)
      end
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 37)
      end
      lay_brick('IFB/2', 9, 29)
      4.times do |i|
        lay_brick('IFB', 9, 30 + (i * 2))
      end
      @height += 2.5
    end

    def self.create_brick_row15
      add_kiln_layer
      lay_bagwall_b
      lay_brick('arch1_27', 5, 8)
      lay_brick('arch1_27_refractory', 5, 8)
      lay_brick('arch1_27', 5, 9)
      lay_brick('arch1_27_refractory', 5, 9)
      lay_brick('Skew3inch', 1, 8)
      lay_brick('Skew3inch', 1, 8.666)
      lay_brick('Skew3inch', 1, 9.333)
      lay_brick_rotated('Skew3inch', 8.333, 8.666, 180.degrees)
      lay_brick_rotated('Skew3inch', 8.333, 9.333, 180.degrees)
      lay_brick_rotated('Skew3inch', 8.333, 10, 180.degrees)
      5.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      lay_brick('IFB/4', 0, 10)
      3.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
      end
      lay_brick('FB/2', 1, 7)
      lay_brick('FB/4', 1, 10)
      lay_brick_rotated('FB', 0, 10.5)
      lay_brick_rotated('LG', 0, 12.5)
      lay_brick_rotated('FB', 0, 15)
      # lay_brick_rotated('FB/4/2', 1, 15)
      # Bourry Box end
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 0)
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 1)
      end
      lay_brick_rotated('LG', 0, 24)
      lay_brick_rotated('FB', 0, 26.5)
      lay_brick('IFB3/4', 0, 27.5)
      lay_brick('FB3/4', 1, 27.5)

      lay_peeps_b(true)
      3.times do |i|
        lay_brick('FB', 8, 1 + (i * 2))
      end
      lay_brick('FB/2', 8, 7)
      lay_brick('FB/4', 8, 10)
      5.times do |i|
        lay_brick('IFB', 9, i * 2)
      end
      lay_brick('IFB/4', 9, 10)
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 36)
      end
      5.times do |i|
        lay_brick_rotated('IFB', i * 2, 37)
      end
      @height += 2.5
    end

    def self.create_brick_row14
      add_kiln_layer
      lay_bagwall_a
      lay_brick_rotated('arch1_27', 0, 20)
      lay_brick_rotated('arch1_27_refractory', 0, 20)
      lay_brick_rotated('arch1_27', 1, 20)
      lay_brick_rotated('arch1_27_refractory', 1, 20)
      lay_brick_rotated('Skew3inch', 0, 16)
      lay_brick_rotated('Skew3inch', 0.666, 16)
      lay_brick_rotated('Skew3inch', 1.333, 16)
      lay_brick_rotated('Skew3inch', -0.666, 24, 270.degrees)
      lay_brick_rotated('Skew3inch', 0, 24, 270.degrees)
      lay_brick_rotated('Skew3inch', 0.666, 24, 270.degrees)

      lay_brick_rotated('IFB', 0, 0)
      lay_brick_rotated('FB', 2, 0)
      lay_brick_rotated('FB', 4, 0)
      lay_brick_rotated('FB', 6, 0)
      lay_brick_rotated('IFB', 8, 0)
      lay_brick_rotated('FB', 2, 1)
      lay_brick_rotated('FB', 4, 1)
      lay_brick_rotated('FB', 6, 1)

      5.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      lay_brick('FB', 0, 11)
      lay_brick('IFB/2', 0, 13)
      lay_brick('FB', 0, 14)
      lay_brick('FB/2', 1, 1)
      7.times do |i|
        lay_brick('FB', 1, 2 + (i * 2))
      end
      lay_brick('FB', 0, 24)
      lay_brick('FB', 0, 26)
      5.times do |i|
        lay_brick('IFB', 0, 28 + (i * 2))
      end
      lay_brick('FB/2', 1, 24)
      2.times do |i|
        lay_brick('FB', 1, 25 + (i * 2))
      end
      lay_peeps_b(true)
      lay_brick('FB3/4', 8, 1)
      4.times do |i|
        lay_brick('FB', 8, 2.5 + (i * 2))
      end
      4.times do |i|
        lay_brick('IFB', 9, 1 + (i * 2))
      end
      lay_brick('IFB3/4', 9, 9)
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 36)
      end
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 37)
      end
      lay_brick('IFB/2', 9, 29)
      4.times do |i|
        lay_brick('IFB', 9, 30 + (i * 2))
      end
      @height += 2.5
    end

    def self.create_brick_row13
      add_kiln_layer
      lay_bagwall_b
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      lay_brick('LG', 1, 0)
      2.times do |i|
        lay_brick('FB', 3.5 + (i * 2), 0)
      end
      lay_brick('LG', 7.5, 0)
      8.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      lay_brick('FB/2', 1, 2)
      6.times do |i|
        lay_brick('FB', 1, 3 + (i * 2))
      end
      lay_brick('FB/2', 1, 15)
      lay_brick('IFB/2', 0, 24)
      lay_brick('IFB', 0, 25)
      lay_brick('IFB', 0, 27)
      lay_brick('FB', 1, 24)
      lay_brick('FB', 1, 26)
      lay_brick('FB', 1, 28)
      lay_peeps_a
      lay_brick('FB/2', 8, 2)
      13.times do |i|
        lay_brick('FB', 8, 3 + (i * 2))
      end
      4.times do |i|
        lay_brick('IFB', 9, i * 2)
      end
      lay_brick('IFB/2', 9, 8)
      lay_brick('IFB/2', 9, 28)
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 36)
      end
      5.times do |i|
        lay_brick_rotated('IFB', i * 2, 37)
      end
      @height += 2.5
    end

    def self.create_brick_row12
      add_kiln_layer
      lay_bagwall_a
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      lay_brick('LG', 1, 0)
      2.times do |i|
        lay_brick('FB', 3.5 + (i * 2), 0)
      end
      lay_brick('LG', 7.5, 0)
      lay_brick('IFB/2', 0, 0)
      7.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      lay_brick('IFB/2', 0, 15)
      7.times do |i|
        lay_brick('FB', 1, 2 + (i * 2))
      end
      7.times do |i|
        lay_brick('IFB', 0, 24 + (i * 2))
      end
      lay_brick('FB/2', 1, 24)
      2.times do |i|
        lay_brick('FB', 1, 25 + (i * 2))
      end
      13.times do |i|
        lay_brick('FB', 8, 2 + (i * 2))
      end
      lay_brick('FB/2', 8, 28)
      lay_brick('IFB/2', 9, 0)
      5.times do |i|
        lay_brick('IFB', 9, 1 + (i * 2))
      end
      lay_brick('IFB/2', 9, 11)
      13.times do |i|
        lay_brick('IFB', 9, 12 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 36)
      end
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 37)
      end
      @height += 2.5
    end

    def self.create_brick_row11
      add_kiln_layer
      lay_bagwall_b
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)

      5.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      lay_brick('IFB/2', 0, 10)
      lay_brick('FB', 0, 11)
      lay_brick('IFB/2', 0, 13)
      lay_brick('FB', 0, 14)

      6.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
      end
      lay_brick('FB/2', 1, 13)
      lay_brick('FB', 1, 14)
      lay_brick('IFB/2', 1, 0)
      4.times do |i|
        lay_brick('LG', 2 + (i * 1.5), 0)
      end
      lay_brick('IFB/2', 8, 0)
      lay_brick('FB', 0, 24)
      lay_brick('IFB/2', 0, 26)
      lay_brick('IFB', 0, 27)
      lay_brick('FB', 1, 24)
      lay_brick('FB', 1, 26)
      lay_brick('FB/2', 1, 28)

      lay_peeps_c(false)
      5.times do |i|
        lay_brick('FB', 8, 1 + (i * 2))
        lay_brick('IFB', 9, i * 2)
      end
      lay_brick('IFB/2', 9, 10)
      4.times do |i|
        lay_brick_rotated('FB', 1 + (i * 2), 36)
      end
      5.times do |i|
        lay_brick_rotated('IFB', i * 2, 37)
      end
      @height += 2.5
    end

    def self.create_brick_row10
      # header course
      add_kiln_layer
      lay_bagwall_a_header_course
      # door frame
      lay_brick_rotated('LG', 0, 23)

      2.times do |i|
        lay_brick_rotated('LG', 2.5, i * 1.5)
        lay_brick_rotated('LG', 5.5, i * 1.5)
      end

      lay_brick('FB', 4.5, 0)
      lay_brick('FB/2', 4.5, 2)
      lay_brick('FB/2L', 2, 0)
      lay_brick('FB/2/2', 2, 2)
      lay_brick('FB/2L', 7.5, 0)
      lay_brick('FB/2/2', 7.5, 2)
      # col 0
      7.times do |i|
        lay_brick_rotated('LG', 0, i * 1.5)
      end
      lay_brick_rotated('FB', 0, 10.5)
      lay_brick_rotated('FB', 0, 12.5)
      lay_brick_rotated('FB', 0, 13.5)
      lay_brick_rotated('LG', 0, 15.5)
      7.times do |i|
        lay_brick_rotated('LG', 0, 25.5 + (i * 1.5))
      end
      # col 8
      7.times do |i|
        lay_brick_rotated('LG', 8, i * 1.5)
      end
      lay_peeps_b
      5.times do |i|
        lay_brick_rotated('LG', 8, 28.5 + (i * 1.5))
      end
      # chimney end
      3.times do |i|
        lay_brick('LG', i * 1.5, 36)
      end
      lay_brick('FB', 4.5, 36)
      3.times do |i|
        lay_brick('LG', 5.5 + (i * 1.5), 36)
      end
      @height += 2.5
    end

    def self.create_brick_row9
      add_kiln_layer
      lay_bagwall_b
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      # col 0
      lay_brick_rotated('IFB', 0, 0)
      5.times do |i|
        lay_brick('IFB', 0, (i * 2) + 1)
      end
      lay_brick('FB', 0, 11)
      lay_brick('IFB/2', 0, 13)
      lay_brick('FB', 0, 14)

      lay_brick('FB', 0, 24)
      lay_brick('IFB/2', 0, 26)
      lay_brick('IFB', 0, 27)
      # col 1
      lay_brick('FB/2', 1, 1)
      7.times do |i|
        lay_brick('FB', 1, 2 + (i * 2))
      end
      2.times do |i|
        lay_brick('FB', 1, 24 + (i * 2))
      end
      lay_brick('FB/2', 1, 28)
      # col 2
      lay_brick('FB', 2, 0)
      # col 3
      lay_brick('FB/2', 2, 2)
      # col 4
      2.times do |i|
        lay_brick_rotated('LG', 4, 0 + (i * 1.5))
      end
      # col 7
      lay_brick('FB', 7, 0)
      lay_brick('FB/2', 7, 2)
      # col 8
      lay_brick_rotated('IFB', 8, 0)
      lay_brick('FB/2', 8, 1)
      13.times do |i|
        lay_brick('FB', 8, 2 + (i * 2))
      end
      lay_brick('FB/2', 8, 28)
      # col 9
      5.times do |i|
        lay_brick('IFB', 9, (i * 2) + 1)
      end
      lay_peeps_a
      lay_brick('IFB/2', 9, 28)
      lay_brick('FB/2', 1, 36)
      lay_brick('FB/2', 8, 36)
      lay_brick_rotated('IFB', 0, 37)
      lay_brick_rotated('IFB', 8, 37)

      @height += 2.5
    end

    def self.create_brick_row8
      add_kiln_layer
      lay_bagwall_a
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)

      8.times do |i|
        lay_brick('IFB', 0, (i * 2))
      end
      7.times do |i|
        lay_brick('IFB', 0, 24 + (i * 2))
      end
      2.times do |i|
        lay_brick('LG', 1, i * 2)
      end
      lay_brick('FB/2', 1, 4)
      5.times do |i|
        lay_brick('FB', 1, 5 + (2 * i))
      end
      lay_brick('FB/2', 1, 15)
      lay_brick('FB/2', 1, 24)
      2.times do |i|
        lay_brick('FB', 1, 25 + (i * 2))
      end
      3.times do |i|
        lay_brick_rotated('LG', 2.5, i * 1.5)
        lay_brick_rotated('LG', 5.5, i * 1.5)
      end
      lay_brick('FB/4/2', 2, 4)

      lay_brick('FB', 4.5, 0)
      lay_brick('FB/4', 4.5, 2)
      lay_brick('FB', 4.5, 2.5)

      lay_brick('LG', 7.5, 0)
      lay_brick('LG', 7.5, 2)
      lay_brick('FB/4/2', 7.5, 4)
      # col 8
      lay_brick_rotated('LG', 8, 4)
      lay_brick('FB', 8, 8.5)
      lay_brick('FB/4', 8, 10.5)
      9.times do |i|
        lay_brick('FB', 8, 11 + (i * 2))
      end
      # col 9
      2.times do |i|
        lay_brick('IFB', 9, (i * 2))
      end
      lay_brick('LFB', 8, 5.5)
      lay_brick('LFB', 9, 5.5)
      lay_brick('IFB3/4', 9, 8.5)
      14.times do |i|
        lay_brick('IFB', 9, 10 + (i * 2))
      end
      # header over chimney w/hole for soda kiln
      lay_brick_rotated('Cast27x9x5', 2, 36)
      lay_brick('IFB/2', 1, 37)
      lay_brick('IFB/2', 8, 37)
      @height += 2.5
    end

    def self.create_brick_row7
      add_kiln_layer
      lay_bagwall_b

      # col 0
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)

      lay_brick_rotated('IFB', 0, 0)
      7.times do |i|
        lay_brick('IFB', 0, (i * 2) + 1)
      end
      lay_brick('IFB/2', 0, 15)
      lay_brick('IFB/2', 0, 24)
      2.times do |i|
        lay_brick('IFB', 0, 25 + (i * 2))
      end
      # col 1
      lay_brick('IFB/2', 1, 1)
      lay_brick_rotated('LG', 1, 2)
      lay_brick_rotated('FB', 1, 3.5)
      lay_brick('FB3/4', 1, 4.5)
      5.times do |i|
        lay_brick('FB', 1, 6 + (2 * i))
      end
      2.times do |i|
        lay_brick('FB', 1, 24 + (i * 2))
      end
      lay_brick('FB/2', 1, 28)
      # col 2
      lay_brick('FB', 2, 0)
      # col 4
      3.times do |i|
        lay_brick_rotated('LG', 4, 0 + (i * 1.5))
      end
      # col 7
      lay_brick('FB', 7, 0)
      lay_brick_rotated('LG', 7, 2)
      lay_brick_rotated('FB', 7, 3.5)
      # col 8
      lay_brick_rotated('IFB', 8, 0)
      lay_brick('IFB/2', 8, 1)
      lay_brick('FB/4', 8, 4.5)
      lay_brick_rotated('FB', 8, 5)
      lay_brick_rotated('FB', 8, 8)
      lay_brick('FB/2', 8, 9)
      9.times do |i|
        lay_brick('FB', 8, 10 + (i * 2))
      end
      lay_brick('FB/2', 8, 28)
      # col 9
      2.times do |i|
        lay_brick('IFB', 9, (i * 2) + 1)
      end
      10.times do |i|
        lay_brick('IFB', 9, (i * 2) + 9)
      end
      # chimney w/hole for soda kiln B
      lay_brick_rotated('FB', 1, 36)
      lay_brick_rotated('FB', 7, 36)
      lay_brick_rotated('FB/2', 2, 37)
      lay_brick_rotated('FB/2', 7, 37)
      lay_brick_rotated('IFB', 0, 37)
      lay_brick_rotated('IFB', 8, 37)

      @height += 2.5
    end

    def self.create_brick_row4
      add_kiln_layer
      # col 0
      5.times do |i|
        lay_brick('IFB', 0, (i * 2) + 0)
      end
      lay_brick('IFB', 0, 10)
      lay_brick('IFB', 0, 12)
      lay_brick('FB', 0, 14)
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      lay_brick('IFB/2', 0, 24)
      lay_brick('FB/2', 0, 25)
      lay_brick('IFB', 0, 26)
      5.times do |i|
        lay_brick('IFB', 0, (i * 2) + 28)
      end

      # kiln shelf to size flue hole
      # lay_brick_rotated_vertically('shelf', 2.33, 38)

      # col 1
      lay_brick('IFB', 1, 0)
      lay_brick_rotated('FB', 1, 2)
      2.times do |i|
        lay_brick_rotated('LG', 1, (i * 1.5) + 3)
      end
      lay_brick('FB/2', 1, 6)
      3.times do |i|
        lay_brick('FB', 1, 7 + (i * 2))
      end
      lay_brick('FB/2', 1, 13)
      lay_brick('FB', 1, 14)
      lay_brick('FB/2', 1, 24)
      2.times do |i|
        lay_brick('FB', 1, (i * 2) + 25)
      end

      # col 2
      lay_brick('FB', 2, 0)
      lay_bagwall_a
      # col 3
      # col 4
      4.times do |i|
        lay_brick_rotated('LG', 4, 0 + (i * 1.5))
      end
      # col 5
      # col 6
      # col 7
      lay_brick('FB', 7, 0)
      lay_brick_rotated('FB', 7, 2)
      2.times do |i|
        lay_brick_rotated('LG', 7, (i * 1.5) + 3)
      end
      # col 8
      lay_brick('IFB', 8, 0)
      lay_brick_rotated('FB', 8, 8)
      10.times do |i|
        lay_brick('FB', 8, (i * 2) + 9)
      end
      # col 9
      lay_brick('IFB', 9, 0)
      lay_brick('IFB', 9, 2)
      lay_brick('FB', 9, 4)
      lay_brick('IFB/2', 9, 9)
      lay_brick('IFB', 9, 10)
      lay_brick('IFB', 9, 12)
      lay_brick('FB', 9, 14)
      lay_brick('IFB', 9, 16)
      lay_brick('FB', 9, 18)
      lay_brick('IFB', 9, 20)
      lay_brick('FB', 9, 22)
      lay_brick('FB', 9, 24)

      6.times do |i|
        lay_brick('IFB', 9, (i * 2) + 26)
      end

      # shelves
      lay_brick('shelf', 2.333, 10.833)
      lay_brick_rotated_vertically('cone', 3, 13)
      lay_brick_rotated_vertically('cone', 7.5, 13)

      2.times do |i|
        lay_brick('shelf', 2.333, 15.5 + (i * 2.833))
        lay_brick_rotated_vertically('cone', 3, 17.666 + (i * 2.833))
        lay_brick_rotated_vertically('cone', 7.5, 17.666 + (i * 2.833))  
      end
      2.times do |i|
        lay_brick('shelf', 2.333, 23 + (i * 2.833))
        lay_brick_rotated_vertically('cone', 3, 23 + (i * 2.833))
        lay_brick_rotated_vertically('cone', 7.5, 23 + (i * 2.833))  
      end
      # chimney w/hole for soda kiln A
      lay_brick_rotated('FB/2', 2, 36)
      lay_brick_rotated('FB/2', 7, 36)
      lay_brick_rotated('FB', 1, 37)
      lay_brick_rotated('FB', 7, 37)
      @height += 2.5
    end

    def self.lay_peeps_a
      lay_brick('IFB', 9, 8 + 1)
      lay_brick('FB', 9, 8 + 3)
      lay_brick('IFB/4', 9, 8 + 5)
      lay_brick('FB', 9, 8 + 5.5)
      lay_brick('IFB/4', 9, 8 + 7.5)
      lay_brick('FB', 9, 8 + 8)
      lay_brick('IFB/4', 9, 8 + 10)
      lay_brick('FB', 9, 8 + 10.5)
      lay_brick('IFB/4', 9, 8 + 12.5)
      lay_brick('FB', 9, 8 + 13)
      lay_brick('IFB/4', 9, 8 + 15)
      lay_brick('FB', 9, 8 + 15.5)
      lay_brick('IFB/4', 9, 8 + 17.5)
      lay_brick('FB', 9, 8 + 18)
    end

    def self.create_brick_row5
      add_kiln_layer
      lay_bagwall_b
      # door frame
      lay_brick('FB', 0, 15)
      lay_brick('FB', 1, 15)
      lay_brick('FB', 0, 23)
      lay_brick('FB', 1, 23)

      lay_brick_rotated('IFB', 0, 0)
      lay_brick_rotated('IFB', 8, 0)
      6.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      lay_brick('FB/2', 0, 13)
      4.times do |i|
        lay_brick('FB', 1, 6 + (i * 2))
      end


      lay_brick('FB/2', 0, 26)
      lay_brick('IFB', 0, 27)
      lay_brick('FB', 1, 26)
      lay_brick('FB/2', 1, 28)

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
      # holes
      lay_brick_rotated('Hole', 0, 14)
      lay_brick_rotated('Hole', 0, 25)
      lay_brick_rotated('Hole', 8, 14)
      lay_brick_rotated('Hole', 8, 18)
      lay_brick_rotated('Hole', 8, 22)
      lay_brick_rotated('Hole', 8, 25)
      # row 8 port wall
      lay_brick('FB', 8, 8)
      lay_brick('FB', 8, 10)
      lay_brick('FB', 8, 12)
      lay_brick('FB/2', 8, 15)
      lay_brick('FB', 8, 16)
      lay_brick('FB/2', 8, 19)
      lay_brick('FB', 8, 20)
      lay_brick('FB', 8, 23)
      lay_brick('FB', 8, 26)
      lay_brick('FB/2', 8, 28)

      # row 9 port wall
      lay_brick('FB/2', 9, 8)
      lay_brick('IFB', 9, 9)
      lay_brick('IFB', 9, 11)
      lay_brick('FB/2', 9, 13)
      lay_brick('FB', 9, 15)
      lay_brick('FB/2', 9, 17)
      lay_brick('FB', 9, 19)
      lay_brick('FB/2', 9, 21)
      lay_brick('FB', 9, 23)
      lay_brick('FB/2', 9, 26)
      lay_brick('IFB', 9, 27)

      # chimney w/hole for soda kiln B
      lay_brick_rotated('FB', 1, 36)
      lay_brick_rotated('FB', 7, 36)
      lay_brick_rotated('FB/2', 2, 37)
      lay_brick_rotated('FB/2', 7, 37)
      lay_brick_rotated('IFB', 0, 37)
      lay_brick_rotated('IFB', 8, 37)
      @height += 2.5
    end

    def self.lay_peeps_b(make_last_lg = false)
      lay_brick_rotated('FB', 8, 10.5)
      7.times do |i|
        if !make_last_lg && i == 6
          lay_brick_rotated('FB', 8, 12.5 + (i * 2.5))
        else
          lay_brick_rotated('LG', 8, 12.5 + (i * 2.5))
        end
      end
    end

    def self.create_brick_row6
      add_kiln_layer
      lay_bagwall_a
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      5.times do |i|
        lay_brick('IFB', 0, (i * 2))
      end
      lay_brick('IFB/2', 0, 10)
      lay_brick('FB', 0, 11)
      lay_brick('IFB/2', 0, 13)
      lay_brick('FB', 0, 14)
      lay_brick('IFB/2', 0, 24)
      lay_brick('FB', 0, 25)
      lay_brick('IFB/2', 0, 27)
      5.times do |i|
        lay_brick('IFB', 0, 28 + (i * 2))
      end
      3.times do |i|
        lay_brick('LG', 1, i * 2)
      end
      lay_brick('FB/2', 1, 6)
      lay_brick('FB', 1, 7)
      lay_brick('FB', 1, 9)
      lay_brick('FB', 1, 11)
      lay_brick('FB/2', 1, 13)
      lay_brick('FB', 1, 14)
      lay_brick('FB/2', 1, 24)
      lay_brick('FB', 1, 25)
      lay_brick('FB', 1, 27)

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
      # col 8
      lay_brick_rotated('FB', 8, 8)
      lay_brick('FB', 8, 9)
      lay_peeps_c

      # col 9
      lay_brick('IFB', 9, 0)
      lay_brick('IFB', 9, 0 + 2)
      lay_brick('IFB', 9, 9 + 1)
      5.times do |i|
        lay_brick('IFB', 9, (i * 2) + 28)
      end
      # chimney w/hole for soda kiln A
      lay_brick_rotated('FB/2', 2, 36)
      lay_brick_rotated('FB/2', 7, 36)
      lay_brick_rotated('FB', 1, 37)
      lay_brick_rotated('FB', 7, 37)
      @height += 2.5
    end

    def self.lay_peeps_c(use_half_at_end = true)
      7.times do |i|
        lay_brick('FB', 8, 11 + (i * 2.5))
        lay_brick('FB', 9, 11 + (i * 2.5))
        if i < 6
          lay_brick('FB/4', 8, 13 + (i * 2.5))
          lay_brick('IFB/4', 9, 13 + (i * 2.5))
          # lay_brick_rotated('FB/2L', 8, 13 + (i * 2.5))
        elsif use_half_at_end
          lay_brick('FB/2', 8, 13 + (i * 2.5))
        else
          lay_brick('FB/2', 8, 13 + (i * 2.5))
          lay_brick('IFB/2', 9, 13 + (i * 2.5))
        end
      end
    end

    def self.lay_bagwall_b(include_chimney = true)
      @sub = 'lay_bagwall_b'
      lay_brick_rotated('LG', 1, 29)
      lay_brick_rotated('LG', 3, 29)
      lay_brick_rotated('LG', 5, 29)
      lay_brick_rotated('LG', 7, 29)
      lay_brick_rotated('LG', 1, 30.5)
      lay_brick_rotated('LG', 3, 30.5)
      lay_brick_rotated('LG', 5, 30.5)
      lay_brick_rotated('LG', 7, 30.5)
      if include_chimney
        2.times do |i|
          lay_brick('FB', 1, (i * 2) + 32)
          lay_brick('FB', 8, (i * 2) + 32)
        end
        4.times do |i|
          lay_brick('IFB', 0, (i * 2) + 29)
          lay_brick('IFB', 9, (i * 2) + 29)
        end
      end
      @sub = ''
    end

    def self.lay_bagwall_a
      @sub = 'lay_bagwall_a'
      4.times do |i|
        lay_brick('FB', 1, (i * 2) + 29)
        lay_brick('FB', 8, (i * 2) + 29)
      end
      lay_brick('FB', 2.5, 29)
      lay_brick('FB/2', 2.5, 31)
      lay_brick('FB', 4.5, 29)
      lay_brick('FB/2', 4.5, 31)
      lay_brick('FB', 6.5, 29)
      lay_brick('FB/2', 6.5, 31)
      @sub = ''
    end

    def self.lay_bagwall_a_header_course
      @sub = 'lay_bagwall_a_header'

      lay_brick('FB', 2.5, 29)
      lay_brick('FB/2', 2.5, 31)
      lay_brick('FB', 4.5, 29)
      lay_brick('FB/2', 4.5, 31)
      lay_brick('FB', 6.5, 29)
      lay_brick('FB/2', 6.5, 31)
      @sub = ''
    end

    def self.lay_brick(brick_type, bx, by)
      return if reject_coordinates(bx, by)

      @grid = "(#{bx}, #{by})"
      componentdefinition = find_componentdefinition(brick_type)
      transformation = Geom::Transformation.new([bx * @unit, by * @unit, @height])
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      assign_instance_name componentinstance
    end

    def self.lay_brick_rotated(brick_type, bx, by, degrees_to_rotate = 90.degrees)
      return if reject_coordinates(bx, by)

      @grid = "(#{bx}, #{by})"
      componentdefinition = find_componentdefinition(brick_type)
      w = componentdefinition.bounds.height
      target_point = Geom::Point3d.new(0, 0, 0)
      vector = Geom::Vector3d.new(0, 0, 1)
      t = Geom::Transformation.rotation(target_point, vector, degrees_to_rotate)
      transformation = Geom::Transformation.new([(bx * @unit) + w, by * @unit, @height]) * t
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      assign_instance_name componentinstance
    end

    def self.lay_brick_rotated_vertically(brick_type, bx, by)
      return if reject_coordinates(bx, by)

      @grid = "(#{bx}, #{by})"
      componentdefinition = find_componentdefinition(brick_type)
      d = componentdefinition.bounds.depth
      target_point = Geom::Point3d.new(0, 0, 0)
      vector = Geom::Vector3d.new(1, 0, 0)
      degrees_to_rotate = 90.degrees
      t = Geom::Transformation.rotation(target_point, vector, degrees_to_rotate)
      transformation = Geom::Transformation.new([(bx * @unit), (by * @unit) + d, @height]) * t
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      assign_instance_name componentinstance
    end

    def self.assign_instance_name(componentinstance)
      componentinstance.name = "#{@layer_name} #{@sub} #{@grid} #{@serial}"
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
      componentdefinition1 = find_componentdefinition('IFB')
      componentdefinitionX = find_componentdefinition('IFBX')
      componentdefinition = componentdefinition1
      # have to swap l & w because of the rotation applied
      l = componentdefinition.bounds.width
      w = componentdefinition.bounds.height
      target_point = Geom::Point3d.new(0, 0, 0)
      vector = Geom::Vector3d.new(0, 0, 1)
      degrees_to_rotate = 90.degrees
      t = Geom::Transformation.rotation(target_point, vector, degrees_to_rotate)
      5.times do |i|
        38.times do |j|
          if j %5 == 0 
           componentdefinition = componentdefinitionX 
          else 
            componentdefinition = componentdefinition1
          end
          @grid = "(#{i*2}, #{j})"
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

    def self.create_skew_brick3
      name = 'Skew3inch'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkKhaki'
      group = compdefinition.entities.add_group
      face = group.entities.add_face [0, 0, 0], [4.415, 0, 0], [2.356, 0, 7.5], [0, 0, 7.5]
      face.pushpull(-3)
    end

    def self.create_skew_brick
      name = 'Skew'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'Lavender'
      group = compdefinition.entities.add_group
      face = group.entities.add_face [0, 0, 0], [4.415, 0, 0], [2.356, 0, 7.5], [0, 0, 7.5]
      face.pushpull(-2.5)
    end

    def self.create_arch_1
      name = 'arch1_27'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkSeaGreen'
      group = compdefinition.entities.add_group

      arc1 = group.entities.add_arc @a27_center, @arch_xaxis, @arch_normal, 49.5, -@a27_angle, @a27_angle, 11
      arc2 = group.entities.add_arc @a27_center, @arch_xaxis, @arch_normal, 54, -@a27_angle, @a27_angle, 11
      # ¿make each one a named brick for the staggered center arch and so they can be counted?
      11.times do |i|
        edge1 = arc1[i]
        edge2 = group.entities.add_line(arc1[i].end, arc2[i].end)
        edge3 = group.entities.add_line(arc2[i].end, arc2[i].start)
        edge4 = group.entities.add_line(arc2[i].start, arc1[i].start)
        face = group.entities.add_face [edge1, edge2, edge3, edge4]
        face.pushpull(-4.5)
      end
    end

    def self.create_arch_2
      name = 'arch2_18'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkSeaGreen'
      group = compdefinition.entities.add_group

      arc1 = group.entities.add_arc @a18_center, @arch_xaxis, @arch_normal, 49.5, -@a18_angle, @a18_angle, 7
      arc2 = group.entities.add_arc @a18_center, @arch_xaxis, @arch_normal, 54, -@a18_angle, @a18_angle, 7
      # ¿make each one a named brick for the staggered center arch and so they can be counted?
      7.times do |i|
        edge1 = arc1[i]
        edge2 = group.entities.add_line(arc1[i].end, arc2[i].end)
        edge3 = group.entities.add_line(arc2[i].end, arc2[i].start)
        edge4 = group.entities.add_line(arc2[i].start, arc1[i].start)
        face = group.entities.add_face [edge1, edge2, edge3, edge4]
        face.pushpull(-4.5)
      end
    end

    def self.create_arch_refractory
      name = 'arch1_27_refractory'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkSalmon'
      group = compdefinition.entities.add_group

      arc2 = group.entities.add_arc @a27_center, @arch_xaxis, @arch_normal, 54, -@a27_angle, @a27_angle, 11
      refractory_x = 15.729
      refractory_y = 55.099 - 47.599
      face = group.entities.add_face [[-refractory_x, 0, refractory_y],
                                      arc2[0].start,
                                      arc2[1].start,
                                      arc2[2].start,
                                      arc2[3].start,
                                      arc2[4].start,
                                      arc2[5].start,
                                      arc2[6].start,
                                      arc2[7].start,
                                      arc2[8].start,
                                      arc2[9].start,
                                      arc2[10].start,
                                      arc2[10].end,
                                      [refractory_x, 0, refractory_y]]
      face.pushpull(-4.5)
    end

    def self.create_rod
      name = 'Rod'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkRed'
      group = compdefinition.entities.add_group
      face = group.entities.add_face(group.entities.add_circle([-1, 1, 1], Y_AXIS, 1))
      face.pushpull(40.5)
    end

    def self.create_cone
      name = 'cone'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkRed'
      group = compdefinition.entities.add_group
      face = group.entities.add_face(group.entities.add_circle([-1, 1, 1], Y_AXIS, 1))
      face.pushpull(2.5)
    end

    def self.create_components
      create_arch_1
      create_arch_2
      create_arch_refractory
      create_skew_brick3
      create_skew_brick
      create_rod
      create_cone
      l = 9.0
      w = 4.5
      h = 2.5
      create_brick(l, w, h, 'FB', 'Goldenrod')
      create_brick(l, w, h, 'Hole', 'Black')
      create_brick(l, l, h, 'Floor Tile', 'DarkGoldenrod')
      create_brick(l, w, h, 'IFB', 'Cornsilk')
      create_brick(l, w, h, 'IFBX', 'LightSkyBlue')
      create_brick(13.5, w, h, 'LFB', 'BurlyWood')
      create_brick(l, 6.75, h, 'LG', 'Khaki')
      create_brick(l / 2, w, h, 'FB/2', 'Goldenrod')
      create_brick(l / 2, w, h, 'IFB/2', 'Cornsilk')
      create_brick(l / 4, w, h, 'FB/4', 'Goldenrod')
      create_brick(l / 4, w, h, 'IFB/4', 'Cornsilk')
      create_brick(l, w / 2, h, 'FB/2L', 'Goldenrod')
      create_brick(l / 2, w / 2, h, 'FB/2/2', 'Goldenrod')
      create_brick(l / 4, w / 2, h, 'FB/4/2', 'Goldenrod')
      create_brick(3 * l / 4, w, h, 'FB3/4', 'Goldenrod')
      create_brick(3 * l / 4, w, h, 'IFB3/4', 'Cornsilk')
      create_brick(16.0, 8.0, 8.0, 'Cinder Block', 'SlateGray')
      create_brick(12, 24, 1, 'shelf', 'PapayaWhip')
      create_brick(171.0, 45.0, 3.5, 'Slab', 'LightSlateGray')
      create_brick(27.0, 9.0, 5, 'Cast27x9x5', 'Thistle')
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
