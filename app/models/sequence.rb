require "midi"

class Sequence < ApplicationRecord
  has_many :notes

  def play_arpeggio(notes)
    sequence = []
    notes.each do |note|
      sequence.push(note.value)
    end
      # prompt the user to select an input and output

    @output = UniMIDI::Output.use(:last)

    MIDI.using(@output) do
      sequence.each { |n| play n, 0.1 }
    end
    self.play_arpeggio(self.notes)
  end

  def listen
    @input = UniMIDI::Input.use(:last)
    sequence = self
    MIDI.using(@input) do
      count = 0
      thru_except :note do |message|
        # only takes evens to not record note release
        if count % 2 == 0
          sequence.notes.create(value: "#{message.name}")
          sequence.save
        end
        count += 1
      end
      join
    end
  end
end
