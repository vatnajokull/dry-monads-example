module Api::V1
  class ProjectsController < ApplicationController
    def create
      result = Api::V1::Projects::Operation::Create.new(params.to_unsafe_hash).call

      if result.success?
        result_values = result.value!

        render json: result_values[:model],
               status: result_values[:status],
               serializer: Api::V1::Projects::Serializer::Show
      else
        failure = result.failure

        render json: { errors: failure[:errors] },
               status: failure[:status]
      end
    end
  end
end
