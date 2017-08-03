require "midi"

class Sequence < ApplicationRecord
  has_many :notes
  # @@output = UniMIDI::Output.gets
  # @@input = UniMIDI::Input.gets
  @@output = nil
  # @@input = UniMIDI::Input.all[0].open
  @@playing = false
  @@recording = false

  def self.current_device
    @@output
  end

  def self.display_midi_devices
    devices = []
    UniMIDI::Output.all.each do |device|
      devices.push({id: device.id, name: device.name})
    end
  end

  def self.find_midi_device(device_id)
    found_device = {}
    UniMIDI::Output.all.each do |device|
      if device.id == device_id.to_i
        found_device = device
      end
    end
    found_device
  end

  def self.set_midi_device(device_id)
    @@output = Sequence.find_midi_device(device_id)
    puts @@output
  end

  def initialize_play
    @@playing = true
    # Ensures only one instance of play
    self.playing = true
    self.save
  end

  def play_arpeggio(notes, tempo, resolution, direction)
    if @@playing && notes.any?
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
        sequence.each do |n|
          if n == 'R'
            sleep (60/tempo/resolution)
          else
            play n, (60/tempo/resolution)
          end
        end
      end
      self.play_arpeggio(notes, tempo, resolution, direction)
    end
  end

  def stop_arpeggio
    @@playing = false
    self.playing = false
    self.save
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
