class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :sc_id
  has_many :followings, :through => :user_followings
  has_many :user_followings
  has_many :master_tracks
  has_many :mix_downs
  has_many :tracks
  has_many :projects, :foreign_key => 'creator_id'
  has_many :likes
  
  validates :email, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :sc_id, presence: true, numericality: true

  def with_associations
    attributes = {
      :follows => self.get_users_followings,
      :followers => self.get_users_followed_by
    }
    self.attributes.merge(attributes)
  end

  def get_users_followings
    self.followings
  end

  def get_users_followed_by
    User.all.select{ |user| user.followings.include?(self) }
  end

  def mix_downs_with_associations
    self.mix_downs.map {|mix_down| mix_down.with_associations}
  end
end
