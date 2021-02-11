RSpec.describe Api::V1::Projects::Operation::Create do
  subject(:result) { described_class.new(params).call }

  let(:name) { FFaker::Book.title }
  let(:description) { FFaker::Book.description }
  let(:project_status) { 'open' }
  let(:price) { 9.99 }

  let(:params) do
    {
      name: name,
      description: description,
      status: project_status,
      price: price
    }
  end

  describe 'Success' do
    it 'creates new project' do
      expect { result }.to change(Project, :count).by(1)

      result_values = result.value!
      project = Project.last
      expect(result_values[:model]).to eq(project)
      expect(result_values[:status]).to eq(:created)
      expect(result).to be_success
    end
  end

  describe 'Failure' do
    describe 'unprocessable_entity' do
      let(:status) { :unprocessable_entity }

      context 'without params' do
        let(:params) { {} }
        let(:errors) do
          {
            name: ['is missing'],
            description: ['is missing'],
            price: ['is missing'],
            status: ['is missing']
          }
        end

        include_examples 'has validation errors'
      end

      context 'with wrong param types' do
        let(:name) { 42 }
        let(:description) { ['some value'] }
        let(:project_status) { ['first status', 'second status'] }
        let(:price) { 'some price' }
        let(:errors) do
          {
            name: ['must be a string'],
            description: ['must be a string'],
            status: ['must be a string'],
            price: ['must be a decimal']
          }
        end

        include_examples 'has validation errors'
      end

      context 'when name is too long' do
        let(:name) { 'a' * 101 }
        let(:errors) { { name: ['size cannot be greater than 100'] } }

        include_examples 'has validation errors'
      end

      context 'when description is too long' do
        let(:name) { 'z' * 65_537 }
        let(:errors) { { name: ['size cannot be greater than 100'] } }

        include_examples 'has validation errors'
      end

      context 'when price is negative' do
        let(:price) { -1 }
        let(:errors) { { price: ['must be greater than 0'] } }

        include_examples 'has validation errors'
      end

      context 'with wrong status' do
        let(:project_status) { 'wrong-status' }
        let(:errors) { { status: ['must be one of: open, closed'] } }

        include_examples 'has validation errors'
      end
    end
  end
end
