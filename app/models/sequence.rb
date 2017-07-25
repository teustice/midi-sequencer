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

  def play_arpeggio(notes)
    if @@playing
      sequence = []
      notes.each do |note|
        sequence.push(note.value)
      end

      # Play sequence
      MIDI.using(@@output) do
        sequence.each { |n| play n, 0.2 }
      end
      self.play_arpeggio(notes)
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
