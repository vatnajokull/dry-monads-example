module Api::V1::Projects::Operation
  class Create < Operation::Base
    param :contract, default: proc { Api::V1::Projects::Contract::Create }

    def call
      values = yield validate(params)
      project = yield create_project(values)

      Success({
                model: project,
                status: :created
              })
    end

    private

    def create_project(values)
      project = Project.create(values)

      return Success(project) if project.persisted?

      Failure(
        status: :unprocessable_entity,
        errors: project.errors.to_hash
      )
    end
  end
end
