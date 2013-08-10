class MasterTrack < ActiveRecord::Base
  attr_accessible :name, :user_id, :project_id, :sc_id
  
  belongs_to :user
  belongs_to :project
end
