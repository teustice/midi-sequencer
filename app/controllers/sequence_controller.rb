class SequenceController < ActionController::Base
  def index
    @sequence = Sequence.create
  end

  def play
    Sequence.find(params['sequence_id']).play_arpeggio
  end
end
