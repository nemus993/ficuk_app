require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) do
    User.create(first_name: "John", last_name: "Doe",
                birthday: "1960-08-08", email: "example@gmail.com",
                password: "example1234", password_confirmation: "example1234")
  end
  let(:followed) do
    User.create(first_name: "Anne", last_name: "Smith",
                birthday: "1960-08-08", email: "1234@gmail.com",
                password: "password", password_confirmation: "password")
  end

  let(:relationship) do
    Relationship.create(follower_id: follower.id, followed_id: followed.id)
  end

  it 'should be valid' do
    expect(relationship).to be_valid
  end
  it 'requires follower_id' do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end
  it 'requires followed_id' do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end
  it 'is associated with user as follower' do
    expect(relationship).to respond_to(:follower)
  end
  it 'is associated with user as followed' do
    expect(relationship).to respond_to(:followed)
  end
end
