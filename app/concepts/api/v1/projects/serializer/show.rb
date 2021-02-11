module Api::V1::Projects::Serializer
  class Show < ActiveModel::Serializer
    attributes :id,
               :name,
               :description,
               :price,
               :status,
               :created_at
  end
end
