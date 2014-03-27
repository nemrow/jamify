class CommentsController < ApplicationController

  def create
    project = Project.find_by_id(params[:project_id])
    master_track = MasterTrack.find_by_id(params[:master_track_id])
    mix_down = MixDown.find_by_id(params[:mix_down_id])
    track = Track.find_by_id(params[:track_id])

    commentable = get_commentable_type(project, master_track, mix_down, track)

    if commentable
      comment = Comment.create(:content => params[:content])
      commentable.comments << comment
      render :json => {:response => true, :comment_id => comment.id}
    else
      render :json => {:response => false}
    end
  end

  private
    def get_commentable_type(project, master_track, mix_down, track)
      if master_track
        master_track
      elsif mix_down
        mix_down
      elsif track
        track
      elsif project  
        project
      end
    end
end
