require "midi"

class Sequence < ApplicationRecord

  def self.play_arpeggio

    # prompt the user to select an input and output

    @input = UniMIDI::Input.use(:first)
    @output = UniMIDI::Output.use(:last)

    MIDI.using(@output) do
      5.times do
        5.times do |oct|
          octave oct
          %w{C E G B}.each { |n| play n, 0.05 }
        end
      end
    end
  end
end
