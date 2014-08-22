class SearchController < ApplicationController
  def search_all
    mix_downs = MixDownSearch.new(params[:keywords]).results
    render :json => {:response => true, :mix_downs => mix_downs}
  end
end
