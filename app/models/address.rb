class Address < ActiveRecord::Base
  belongs_to :user,
             inverse_of: :addresses
end
