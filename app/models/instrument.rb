class Instrument < ActiveRecord::Base
  attr_accessible :name

  has_many :tracks, :through => :track_instruments
  has_many :track_instruments
end
