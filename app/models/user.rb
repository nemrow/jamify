class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :sc_id
end
