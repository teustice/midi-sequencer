class Note < ApplicationRecord
  belongs_to :sequence
  @@output = UniMIDI::Output.use(:last)

  def play_note
    note = self
    MIDI.using(@@output) do
      play note.value, 0.3
    end
  end
end
