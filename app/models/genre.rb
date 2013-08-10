class Genre < ActiveRecord::Base
  attr_accessible :name

  has_many :projects, :through => :project_genres
  has_many :project_genres
end
