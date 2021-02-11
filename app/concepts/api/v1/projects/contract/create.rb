module Api::V1::Projects::Contract
  class Create < Dry::Validation::Contract
    params do
      required(:name).filled(:string, max_size?: Constants::Project::NAME_MAX_LENGTH)
      required(:description).filled(:string, max_size?: Constants::Project::DESCRIPTION_MAX_LENGTH)
      required(:price).filled(:decimal, gt?: 0)
      required(:status).filled(:string, included_in?: Project.statuses.keys)
    end
  end
end
