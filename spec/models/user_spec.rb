require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create(first_name: "John", last_name: "Doe",
                birthday: "1960-08-08", email: "example@gmail.com",
                password: "example1234", password_confirmation: "example1234")
  end
  let(:user2) do
    User.create(first_name: "Anne", last_name: "Smith",
    birthday: "1960-08-08", email: "1234@gmail.com",
    password: "password", password_confirmation: "password")
  end

  it 'is valid' do
    expect(user).to be_valid
  end
  it 'is invalid without first name' do
    user.first_name = nil
    expect(user).not_to be_valid
  end
  it 'is invalid without last name' do
    user.last_name = nil
    expect(user).not_to be_valid
  end
  it 'is invalid without birthday' do
    user.birthday = nil
    expect(user).not_to be_valid
  end
  it 'is invalid without email' do
    user.email = nil
    expect(user).not_to be_valid
  end
  it 'is invalid without password' do
    user.password = nil
    expect(user).not_to be_valid
  end
  it 'is invalid when password not confirmed' do
    expect(user.password).to eq(user.password_confirmation)
  end
  it 'has many tweets' do
    user.tweets.build(content: "Example tweet!")
    expect(user.tweets.map(&:content)).to eq(['Example tweet!'])
  end
  it 'has many relationships' do
    user.active_relationships.build(follower_id:user.id, followed_id:user2.id)
    expect(user.active_relationships.map(&:follower_id)).to eq([user.id])
  end
  it 'can follow other users' do
    expect(user.following?(user2)).not_to be true
    user.follow(user2)
    expect(user.following?(user2)).to be true
  end
end
