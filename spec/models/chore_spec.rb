require 'rails_helper'

RSpec.describe Chore, type: :model do
  chore = FactoryGirl.build(:chore)
  it { expect(chore).to validate_presence_of(:task)}
  it { expect(chore).to belong_to(:house)}
  it { expect(chore).to have_many(:issues)}
  it { expect(chore).to have_one(:user_promise)}
  it { expect(chore).to have_many(:chore_logs)}

end
