class Like < ActiveRecord::Base
  attr_accessible :user_id, :likeable_id, :likeable_type

  belongs_to :likeable, :polymorphic => true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => [:likeable_id, :likeable_type]

  def self.get_users_likes(user, type)
    case type
    when "Project"
      Project.find(user.likes.where(:likeable_type => 'Project').map{ |like| like.likeable_id })
    when "MixDown"
      MixDown.find(user.likes.where(:likeable_type => 'MixDown').map{ |like| like.likeable_id })
    end
  end

  def self.get_users_by_liked_object(type, object_id)
    case type
    when "Project"
      object = Project.find(object_id)
    when "MixDown"
      object = MixDown.find(object_id)
    end
    object.likes.map{ |like| like.user }
  end

  def self.set_new_like(params)
    user = User.find_by_sc_id(params[:user_sc_id])
    case params[:likeable_type]
    when "Project"
      Project.find(params[:likeable_id]).likes.create(:user_id => user.id)
    when "MixDown"
      MixDown.find(params[:likeable_id]).likes.create(:user_id => user.id)
    end
  end
end
