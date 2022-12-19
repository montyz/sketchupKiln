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
    @grid = 'unk'
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
      create_brick_row11
      create_brick_row12
      create_brick_row13
      create_brick_row14
      create_brick_row15
      create_brick_row16
      create_brick_row17
      model.commit_operation
      hash = {}
      Sketchup.active_model.entities.each do |instance|
        hash[instance.definition.name] = hash.key?(instance.definition.name) ? hash[instance.definition.name] + 1 : 1
      end
      hash.each do |key, value|
        puts "#{key}: #{value}"
      end
    end

    def self.create_brick_row17
      add_kiln_layer
      lay_bagwall_b
      @height += 2.5
    end

    def self.create_brick_row16
      add_kiln_layer
      lay_bagwall_a
      lay_brick('arch1_27', 5, 8)
      lay_brick('Skew3inch', 1, 8)
      lay_brick('Skew3inch', 1, 8.666)
      lay_brick('Skew3inch', 1, 9.333)
      lay_brick_rotated('Skew3inch', 8.333, 8.666, 180.degrees)
      lay_brick_rotated('Skew3inch', 8.333, 9.333, 180.degrees)
      lay_brick_rotated('Skew3inch', 8.333, 10, 180.degrees)
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
      lay_peeps_c
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
      @height += 2.5
    end

    def self.create_brick_row15
      add_kiln_layer
      lay_bagwall_b
      8.times do |i|
        lay_brick('IFB', 0, i * 2)
      end
      7.times do |i|
        lay_brick('FB', 1, 1 + (i * 2))
      end
      lay_brick('FB/2', 1, 15)
      # Bourry Box end
      4.times do |i|
        lay_brick_rotated('IFB', 1 + (i * 2), 0)
      end
      3.times do |i|
        lay_brick_rotated('FB', 2 + (i * 2), 1)
      end
      lay_peeps_b(true)
      4.times do |i|
        lay_brick('FB', 8, 1 + (i * 2))
      end
      lay_brick('FB3/4', 8, 9)
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

      7.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      lay_brick_rotated('IFB/2', 0, 15)
      lay_brick('FB/2', 1, 1)
      7.times do |i|
        lay_brick('FB', 1, 2 + (i * 2))
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
      5.times do |i|
        lay_brick('FB', 8, 2 + (i * 2))
      end
      lay_brick('FB/2', 8, 12)
      8.times do |i|
        lay_brick('FB', 8, 13 + (i * 2))
      end
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
      lay_brick('IFB', 0, 24)
      lay_brick('FB', 0, 26)
      lay_brick('IFB/2', 0, 28)
      lay_brick('FB', 1, 24)
      lay_brick('FB', 1, 26)
      lay_brick('FB/2', 1, 28)

      lay_peeps_c
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
      lay_brick_rotated('FB', 0, 23)

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
      lay_brick_rotated('LG', 0, 24)
      lay_brick_rotated('FB', 0, 25.5)
      lay_brick_rotated('FB', 0, 27.5)
      5.times do |i|
        lay_brick_rotated('LG', 0, 28.5 + (i * 1.5))
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
      bx = 0
      by = 0
      lay_brick_rotated('IFB', bx, by)
      5.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end
      lay_brick('FB', bx, 11)
      lay_brick('IFB/2', bx, 13)
      lay_brick('FB', bx, 14)

      lay_brick('IFB', bx, 24)
      lay_brick('FB', bx, 26)
      lay_brick('IFB/2', bx, 28)
      # col 1
      bx += 1
      lay_brick('FB/2', bx, 1)
      7.times do |i|
        lay_brick('FB', bx, 2 + (i * 2))
      end
      2.times do |i|
        lay_brick('FB', bx, 24 + (i * 2))
      end
      lay_brick('FB/2', bx, 28)
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
      13.times do |i|
        lay_brick('FB', bx, 2 + (i * 2))
      end
      lay_brick('FB/2', bx, 28)
      # col 9
      bx = 9
      5.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
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
      bx = 0
      by = 0
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)

      lay_brick_rotated('IFB', bx, by)
      7.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end
      lay_brick('IFB/2', bx, 15)
      lay_brick('IFB/2', bx, 24)
      2.times do |i|
        lay_brick('IFB', bx, 25 + (i * 2))
      end
      # col 1
      bx += 1
      lay_brick('IFB/2', bx, 1)
      lay_brick_rotated('LG', bx, 2)
      lay_brick_rotated('FB', bx, 3.5)
      lay_brick('FB3/4', bx, 4.5)
      5.times do |i|
        lay_brick('FB', bx, 6 + (2 * i))
      end
      2.times do |i|
        lay_brick('FB', bx, 24 + (i * 2))
      end
      lay_brick('FB/2', bx, 28)
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
      lay_brick_rotated('LG', bx, 2)
      lay_brick_rotated('FB', bx, 3.5)
      # col 8
      bx = 8
      lay_brick_rotated('IFB', bx, 0)
      lay_brick('IFB/2', bx, 1)
      lay_brick('FB/4', 8, 4.5)
      lay_brick_rotated('FB', bx, 5)
      lay_brick_rotated('FB', bx, 8)
      lay_brick('FB/2', bx, 9)
      9.times do |i|
        lay_brick('FB', bx, 10 + (i * 2))
      end
      lay_brick('FB/2', bx, 28)
      # col 9
      bx = 9
      2.times do |i|
        lay_brick('IFB', bx, (i * 2) + 1)
      end
      10.times do |i|
        lay_brick('IFB', bx, (i * 2) + 9)
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
      bx = 0
      by = 0
      5.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      lay_brick('IFB/2', bx, 10)
      lay_brick('FB', bx, 11)
      lay_brick('IFB/2', bx, 13)
      lay_brick('FB', bx, 14)
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      lay_brick('IFB', bx, 24)
      lay_brick('FB', bx, 26)
      5.times do |i|
        lay_brick('IFB', bx, (i * 2) + 28)
      end

      # kiln shelf to size flue hole
      # lay_brick_rotated_vertically('shelf', 2.33, 38)

      # col 1
      bx += 1
      lay_brick('IFB', bx, by)
      by += 2
      lay_brick_rotated('FB', bx, by)
      by += 1
      2.times do |i|
        lay_brick_rotated('LG', bx, (i * 1.5) + by)
      end
      lay_brick('FB/2', bx, 6)
      3.times do |i|
        lay_brick('FB', bx, 7 + (i * 2))
      end
      lay_brick('FB/2', bx, 13)
      lay_brick('FB', bx, 14)
      lay_brick('FB/2', bx, 24)
      2.times do |i|
        lay_brick('FB', bx, (i * 2) + 25)
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
      lay_brick_rotated('FB', bx, 8)
      10.times do |i|
        lay_brick('FB', bx, (i * 2) + 9)
      end
      # col 9
      bx += 1
      by = 0
      lay_brick('IFB', bx, by)
      lay_brick('IFB', bx, by + 2)
      lay_brick('FB', bx, by + 4)
      lay_peeps_a
      by = 28
      5.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      # shelves
      6.times do |i|
        lay_brick('shelf', 2.333, 11 + (i * 3))
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
      lay_brick('IFB/2', 9, 8 + 5)
      lay_brick('FB', 9, 8 + 6)
      lay_brick('IFB/2', 9, 8 + 8)
      lay_brick('FB', 9, 8 + 9)
      lay_brick('IFB/2', 9, 8 + 11)
      lay_brick('FB', 9, 8 + 12)
      lay_brick('IFB/2', 9, 8 + 14)
      lay_brick('FB', 9, 8 + 15)
      lay_brick('IFB/2', 9, 8 + 17)
      lay_brick('FB', 9, 8 + 18)
    end

    def self.create_brick_row5
      add_kiln_layer
      lay_bagwall_b
      # door frame
      lay_brick_rotated('LG', 0, 15.5)
      lay_brick_rotated('FB', 0, 23)
      bx = 0
      by = 0
      # port holes
      lay_brick_rotated('FB', 0, 10.5)
      lay_brick_rotated('FB', 0, 12.5)
      lay_brick_rotated('FB', 0, 13.5)
      lay_brick_rotated('FB', 0, 25.5)
      lay_brick_rotated('FB', 0, 27.5)

      lay_brick_rotated('IFB', 0, 0)
      lay_brick_rotated('IFB', 8, 0)
      4.times do |i|
        lay_brick('IFB', 0, 1 + (i * 2))
      end
      lay_brick('IFB3/4', 0, 9)
      lay_brick('IFB3/4', 0, 24)
      lay_brick('IFB/4', 0, 28.5) 
      lay_brick('FB', 1, 6)
      lay_brick('FB', 1, 8)
      lay_brick('FB/4', 1, 10)
      lay_brick('FB3/4', 1, 24)
      lay_brick('FB/4', 1, 28.5)

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
      # row 8 port wall
      bx = 8
      lay_brick_rotated('FB', bx, 8)
      lay_brick('FB3/4', 8, 9)
      lay_peeps_b(true)
      lay_brick('FB/4', 8, 28.5)
      # row 9 port wall
      bx = 9
      lay_brick('IFB3/4', bx, 9)
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
      6.times do |i|
        lay_brick_rotated('FB', 8, 10.5 + (i * 3))
        if (make_last_lg && i ==5)
          lay_brick_rotated('LG', 8, 12.5 + (i * 3))
        else
          lay_brick_rotated('FB', 8, 12.5 + (i * 3))
        end
      end
    end

    def self.create_brick_row6
      add_kiln_layer
      lay_bagwall_a
      # door frame
      lay_brick_rotated('FB', 0, 16)
      lay_brick_rotated('FB', 0, 23)
      bx = 0
      by = 0
      5.times do |i|
        lay_brick('IFB', 0, (i * 2))
      end
      lay_brick('IFB/2', 0, 10)
      lay_brick('FB', 0, 11)
      lay_brick('IFB/2', 0, 13)
      lay_brick('FB', 0, 14)
      lay_brick('IFB', 0, 24)
      lay_brick('FB', 0, 26)
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
      lay_brick('FB', 1, 24)
      lay_brick('FB', 1, 26)
      lay_brick('FB/2', 1, 28)

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
      bx = 8
      by = 0
      lay_brick_rotated('FB', bx, 8)
      lay_brick('FB', bx, 9)
      lay_peeps_c

      # col 9
      bx = 9
      by = 0
      lay_brick('IFB', bx, by)
      lay_brick('IFB', bx, by + 2)
      by = 8
      lay_brick('IFB', bx, by + 1)
      by += 20
      5.times do |i|
        lay_brick('IFB', bx, (i * 2) + by)
      end
      # chimney w/hole for soda kiln A
      lay_brick_rotated('FB/2', 2, 36)
      lay_brick_rotated('FB/2', 7, 36)
      lay_brick_rotated('FB', 1, 37)
      lay_brick_rotated('FB', 7, 37)
      @height += 2.5
    end

    def self.lay_peeps_c
      6.times do |i|
        lay_brick('FB', 8, 11 + (i * 3))
        lay_brick('FB/2', 8, 13 + (i * 3))
        lay_brick('FB', 9, 11 + (i * 3))
        lay_brick('IFB/2', 9, 13 + (i * 3))
      end
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
      2.times do |i|
        lay_brick('FB', 1, (i * 2) + 32)
        lay_brick('FB', 8, (i * 2) + 32)
      end
      4.times do |i|
        lay_brick('IFB', 0, (i * 2) + 29)
        lay_brick('IFB', 9, (i * 2) + 29)
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
      @grid = "(#{bx}, #{by})"
      componentdefinition = find_componentdefinition(brick_type)
      transformation = Geom::Transformation.new([bx * @unit, by * @unit, @height])
      componentinstance = Sketchup.active_model.entities.add_instance(componentdefinition, transformation)
      componentinstance.material = componentdefinition.material
      componentinstance.layer = @layer
      assign_instance_name componentinstance
    end

    def self.lay_brick_rotated(brick_type, bx, by, degrees_to_rotate = 90.degrees)
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

    def self.create_skew_brick3
      name = 'Skew3inch'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkKhaki'
      group = compdefinition.entities.add_group
      face = group.entities.add_face [0, 0, 0], [4.415, 0, 0], [1.945, 0, 7.5], [0, 0, 7.5]
      face.pushpull(-3)
    end

    def self.create_arch_1
      name = 'arch1_27'
      model = Sketchup.active_model
      definitions = model.definitions
      definitions.add name unless definitions[name]
      compdefinition = definitions[name]
      compdefinition.material = 'DarkSeaGreen'
      group = compdefinition.entities.add_group
      center = [0, 0, -47.599]
      angle = 0.278
      xaxis = [0, 0, 1]
      vector = Geom::Vector3d.new 0, 1, 0
      normal = vector.normalize!

      arc1 = group.entities.add_arc center, xaxis, normal, 49.5, -angle, angle, 11
      arc2 = group.entities.add_arc center, xaxis, normal, 54, -angle, angle, 11
      # ¿make each one a named brick for the staggered center arch and so they can be counted?
      11.times do |i|
        edge1 = arc1[i]
        edge2 = group.entities.add_line(arc1[i].end, arc2[i].end)
        edge3 = group.entities.add_line(arc2[i].end, arc2[i].start)
        edge4 = group.entities.add_line(arc2[i].start, arc1[i].start)
        face = group.entities.add_face [edge1, edge2, edge3, edge4]
        face.pushpull(-9.0)
      end
      # # add an edge to close the shape.
      # closer1 = group.entities.add_line(arc1[0].start, arc2[-1].end)
      # closer2 = group.entities.add_line(arc2[0].start, arc1[-1].end)
      # # let the edge find it's own face.
      # edges = arc1
      # edges.push(closer2)
      # edges.push(*arc2)
      # edges.push(closer1)
      # face = group.entities.add_face edges
      # face.pushpull(-9.0)
    end

    def self.create_components
      create_arch_1
      create_skew_brick3
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
