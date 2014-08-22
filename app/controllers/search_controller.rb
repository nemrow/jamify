class SearchController < ApplicationController
  def search_all
    mix_downs = MixDownSearch.new(params[:keywords]).results
    mix_downs_data_as_json = mix_downs.map do |mix_down|
      mix_down.build_data_hash
    end
    render :json => {:response => true, :mix_downs => mix_downs_data_as_json}
  end
end
