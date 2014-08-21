class SearchController < ApplicationController
  def search_all
    mix_downs = Search.all_mix_downs_containing_keywords(params[:keywords], 25)
    render :json => {:response => false, :mix_downs => mix_downs}
  end
end
