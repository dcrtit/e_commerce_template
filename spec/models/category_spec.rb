require 'rails_helper'

RSpec.describe Category, type: :model do
  # Association test
  # ensure Category model has a 1:m relationship with the Product model
  it { should have_many(:products).dependent(:destroy) }
  # Validation tests
  # ensure columns name and created_by are present before saving
  it { should validate_presence_of(:name) }
end
