require 'rails_helper'

RSpec.describe Issue, type: :model do
  issue = FactoryGirl.build(:rule_issue)
  it { expect(issue).to validate_length_of(:reason).is_at_least(5)}
  it { expect(issue).to belong_to(:creator)}
  it { expect(issue).to belong_to(:issuable)}
end
