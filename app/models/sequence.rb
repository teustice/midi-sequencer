require "midi"

class Sequence < ApplicationRecord
  has_many :notes

  def play_arpeggio(notes)
    sequence = []
    if notes.include('stop')
      puts "STOOOP"
    else
      notes.each do |note|
        sequence.push(note.value)
      end
      sequence = sequence.join(" ")
      byebug
      # prompt the user to select an input and output
    end

    @input = UniMIDI::Input.use(:first)
    @output = UniMIDI::Output.use(:last)

    MIDI.using(@output) do
      5.times do
        5.times do |oct|
          octave oct
          %w{"#{sequence}"}.each { |n| play n, 0.05 }
        end
      end
    end
  end
end
