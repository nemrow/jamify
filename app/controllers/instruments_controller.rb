class InstrumentsController < ApplicationController
  def create
    track = Track.find(params[:track_id])
    instrument = Instrument.find_or_create_by_name(params[:instrument][:name].downcase)
    if instrument
      track.instruments << instrument
      render :json => {:response => true}
    else
      render :json => {:response => false}
    end
  end
end
