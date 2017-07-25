class SequenceController < ApplicationController
  def index
    @sequence = Sequence.all.last
    @note = @sequence.notes.new
    @scale = ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B','C']
    @octave = params[:octave].to_i || 4
  end

  def show
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  def update
    @sequence = Sequence.find(params['id'])
    respond_to do |format|
      if @sequence.update(sequence_params)
        format.html { redirect_to root_path }
        format.js
      else
        format.html { redirect_to root_path }
      end
    end
  end

  def play
    sequence = Sequence.find(params['sequence_id'])
    Sequence.initialize_play
    sequence.play_arpeggio(sequence.notes, sequence.tempo, sequence.resolution, sequence.direction)
    respond_to do |format|
      format.js
    end
  end

  def stop
    sequence = Sequence.find(params['sequence_id'])
    sequence.stop_arpeggio
    respond_to do |format|
      format.js
    end
  end

  def reset_sequence
    @sequence = Sequence.find(params['sequence_id'])
    @sequence.notes.destroy_all
  end

  #
  # def record
  #   sequence = Sequence.find(params['sequence_id'])
  #   Sequence.initialize_record
  #   sequence.record
  #   respond_to do |format|
  #     format.js
  #   end
  # end
  #
  # def stop_record
  #   @sequence = Sequence.find(params['sequence_id'])
  #   @sequence.stop_recording
  #   respond_to do |format|
  #     format.js
  #   end
  # end


  # def new
  # end
  #
  # def create
  # end
  #
  # def destroy
  # end


private
  def sequence_params
    params.require(:sequence).permit(:tempo, :resolution, :direction, :notes)
  end
end
