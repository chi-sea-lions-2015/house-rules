require 'rails_helper'

RSpec.describe Picture, type: :model do
  let(:picture) { Picture.new }
    it { expect(picture).to belong_to(:message)}
end
