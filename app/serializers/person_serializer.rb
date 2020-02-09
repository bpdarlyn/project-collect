class PersonSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name, :phone, :ci, :address, :full_name
end
