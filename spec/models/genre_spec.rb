require 'spec_helper'

describe Genre do
  let (:project) { FactoryGirl.create(:project) }
  let (:genre) { FactoryGirl.create(:genre) }

  it "should create new genre" do
    new_genre = Genre.find_or_create_by_name('Cat')
    new_genre.name.should == 'Cat'
  end

  it "should find existing genre" do
    old_id = genre.id
    new_find = Genre.find_or_create_by_name(genre.name)
    new_find.id.should == old_id
  end
  
  it { should have_many(:projects) }
end
