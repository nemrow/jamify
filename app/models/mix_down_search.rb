class MixDownSearch < ActiveRecord::Base
  extend Textacular
  attr_accessor :query

  belongs_to :searchable, polymorphic: true

  def initialize(query)
    @query = query
  end

  def results
    if @query.present?
      self.class.search(@query).preload(:searchable).map!(&:searchable).uniq
    else
      Search.none
    end
  end
end