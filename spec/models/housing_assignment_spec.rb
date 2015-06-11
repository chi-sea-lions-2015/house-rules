require 'rails_helper'

RSpec.describe HousingAssignment, type: :model do
    housing = FactoryGirl.build(:housing_assignment)
  it { expect(housing).to belong_to(:user)}
  it { expect(housing).to belong_to(:house)}

end
