class Note < ApplicationRecord
  belongs_to :sequence
  validate :sequence_max, :on => :create

  @@output = UniMIDI::Output.use(:last)

  def sequence_max
    sequence = self.sequence
    puts "Sequences can have a maximum of 16 notes" if sequence.notes.count >= 16
  end

  def play_note
    note = self
    MIDI.using(@@output) do
      play note.value, 0.3
    end
  end
end
