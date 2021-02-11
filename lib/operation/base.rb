module Operation
  class Base
    include Dry::Monads[:result, :do]
    extend Dry::Initializer

    param :params
    param :contract, optional: true

    private

    def validate(options = {})
      form = contract.new(options).call(params)
      return Success(form.values.data) if form.success?

      Failure(
        status: :unprocessable_entity,
        errors: form.errors.to_h
      )
    end
  end
end
