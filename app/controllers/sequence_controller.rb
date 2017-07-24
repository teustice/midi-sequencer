class SequenceController < ApplicationController
  def index
    @sequence = Sequence.create()
    @note = @sequence.notes.new
  end

  def show
    respond_to do |format|
      format.html {redirect_to root_path}
      format.js
    end
  end

  def play
    sequence = Sequence.find(params['sequence_id'])
    sequence.play_arpeggio(sequence.notes)
  end

  def listen
    sequence = Sequence.find(params['sequence_id'])
    sequence.listen
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
  def sequence_params
    params.require(:photo).permit(:note)
  end
end
