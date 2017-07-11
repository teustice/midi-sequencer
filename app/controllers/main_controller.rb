class MainController < ActionController::Base
  def index
    Sequence.play_arpeggio
  end
end
