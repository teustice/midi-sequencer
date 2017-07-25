class SequenceController < ApplicationController
  def index
    @sequence = Sequence.create
    @note = @sequence.notes.new
    @scale = ['C','D','E','F','G','A','B','C']
  end

  def show
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  def play
    sequence = Sequence.find(params['sequence_id'])
    Sequence.initialize_play
    sequence.play_arpeggio(sequence.notes)
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

  def record
    sequence = Sequence.find(params['sequence_id'])
    Sequence.initialize_record
    sequence.record
    respond_to do |format|
      format.js
    end
  end

  def stop_record
    @sequence = Sequence.find(params['sequence_id'])
    @sequence.stop_recording
    respond_to do |format|
      format.js
    end
  end

  def reset_sequence
    @sequence = Sequence.find(params['sequence_id'])
    @sequence.notes.destroy_all
  end

  # def new
  # end
  #
  # def create
  # end
  #
  # def destroy
  # end


private
  # def sequence_params
  #   params.require(:sequence).permit(:note)
  # end
end
