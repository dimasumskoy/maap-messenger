class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :username, :email, :conversations, :bio
end