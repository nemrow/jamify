require 'spec_helper'

describe Genre do
  before do 
    @project = Project.create(:name => 'Project Name')
    @genre = Genre.find_or_create_by_name('dog')
  end

  it "should create new genre" do
    genre = Genre.find_or_create_by_name('cat')
    genre.name.should == 'cat'
  end

  it "should find existing genre" do
    old_id = @genre.id
    new_find = Genre.find_or_create_by_name('dog')
    new_find.id.should == old_id
  end
  
  it { should have_many(:projects) }
end
