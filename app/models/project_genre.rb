class ProjectGenre < ActiveRecord::Base
  attr_accessible :project_id, :genre_id

  belongs_to :project
  belongs_to :genre
end
