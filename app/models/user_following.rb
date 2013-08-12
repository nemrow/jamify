class UserFollowing < ActiveRecord::Base
  attr_accessible :user_id, :following_id
  
  belongs_to :user
  belongs_to :following, :class_name => 'User'
end
