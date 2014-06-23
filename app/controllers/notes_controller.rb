class NotesController < ApplicationController

  def create
    @note = Note.new((params.require(:note).permit(:body_text)).merge({"track_id" => params["track_id"], "user_id" => current_user.id}))
    @note.save!
    redirect_to :back
  end

  def destroy
  end
end
