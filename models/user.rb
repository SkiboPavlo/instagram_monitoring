#
class User
  include Mongoid::Document

  field :username, type: String
  field :password_hash, type: String
  field :password_salt, type: String
  field :tracking_list, type: Array
end
