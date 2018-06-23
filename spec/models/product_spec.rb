require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:category) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
