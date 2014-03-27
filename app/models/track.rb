class Track < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id
  belongs_to :user
  belongs_to :project
  has_many :mix_downs, :through => :mixdown_tracks
  has_many :mix_down_tracks
  has_many :instruments, :through => :track_instruments
  has_many :track_instruments
  has_many :comments, :as => :commentable

  def with_associations
    attributes = {
      :comments => self.comments
    }
    self.attributes.merge(attributes)
  end
end
