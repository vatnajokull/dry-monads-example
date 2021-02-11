RSpec.shared_examples 'has validation errors' do
  it 'has validation errors' do
    expect(result.failure[:status]).to eq(status)
    expect(result.failure[:errors]).to eq(errors)
    expect(result).to be_failure
  end
end
