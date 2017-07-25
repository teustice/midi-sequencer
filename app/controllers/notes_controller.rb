class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @sequence = Sequence.all.last
    @note = @sequence.notes.new(note_params)
    @note.play_note
    respond_to do |format|
      if @note.save
        format.js
      else
        format.html { render root_path }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def note_params
    params.require(:note).permit(:value)
  end
end
