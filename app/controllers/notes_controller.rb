class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @sequence = Sequence.all.last
    @note = @sequence.notes.new(note_params)
    if @note.value != 'R'
      @note.play_note
    end
    if @sequence.notes.count < 16
      respond_to do |format|
        if @note.save
          format.js
        else
          format.html { render root_path }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @sequence = Sequence.all.last
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      format.js
    end
  end

private
  def note_params
    params.require(:note).permit(:value)
  end
end
