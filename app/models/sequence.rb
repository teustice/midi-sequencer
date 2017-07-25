require "midi"

class Sequence < ApplicationRecord
  has_many :notes
  @@output = UniMIDI::Output.use(:last)
  @@input = UniMIDI::Input.use(:last)
  @@playing = false
  @@recording = false

  def self.initialize_play
    @@playing = true
  end

  def play_arpeggio(notes, tempo, resolution, direction)
    if @@playing
      sequence = []
      if direction == 'up'
        notes.each do |note|
          sequence.push(note.value)
        end
      elsif direction == 'down'
        notes.reverse.each do |note|
          sequence.push(note.value)
        end
      elsif direction == 'updown'
        notes.each do |note|
          sequence.push(note.value)
        end
        notes.reverse.each_with_index do |note, i|
          if i != 0 && i != (notes.length - 1)
            sequence.push(note.value)
          end
        end
      end

      # Play sequence
      MIDI.using(@@output) do
        sequence.each { |n| play n, (60/tempo/resolution) }
      end
      self.play_arpeggio(notes, tempo, resolution, direction)
    end
  end

  def stop_arpeggio
    @@playing = false
  end

  # def self.initialize_record
  #   @@recording = true
  # end
  #
  # def record
  #   sequence = self
  #   MIDI.using(@@input) do
  #     count = 0
  #     thru_except :note do |message|
  #       if @@recording && (count % 2 == 0)
  #         # only takes evens to not record note release
  #         sequence.notes.create(value: "#{message.name}")
  #         puts "Created: #{message.name}"
  #       end
  #       count += 1
  #     end
  #   end
  # end
  #
  #
  # def stop_recording
  #   @@recording = false
  # end
end
