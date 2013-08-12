require 'spec_helper'

describe Genre do
  before do 
    @project = FactoryGirl.create(:project)
    @genre = FactoryGirl.create(:genre)
  end

  it "should create new genre" do
    genre = Genre.find_or_create_by_name('Cat')
    genre.name.should == 'Cat'
  end

  it "should find existing genre" do
    old_id = @genre.id
    new_find = Genre.find_or_create_by_name(@genre.name)
    new_find.id.should == old_id
  end
  
  it { should have_many(:projects) }
end
