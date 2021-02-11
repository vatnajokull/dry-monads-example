RSpec.describe 'Api::V1::Projects', type: :request do
  describe 'POST #create' do
    let(:params) do
      {
        name: 'New project',
        description: 'Awesome project',
        status: 'open',
        price: 9.99
      }
    end

    before { post '/api/v1/projects', params: params }

    describe 'Success' do
      it 'creates new project' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
      end
    end

    describe 'Failure' do
      describe 'Unprocessable Entity' do
        let(:params) { {} }

        it 'returns errors' do
          expect(response.content_type).to eq('application/json; charset=utf-8')
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
