require 'rails_helper'

RSpec.describe Website, type: :model do
  let(:website) { create :website }

  it 'validates url' do
    expect(website).to be_valid
  end
end
