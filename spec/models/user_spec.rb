require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.create(first_name: "John", last_name: "Doe",
                birthday: "1960-08-08", email: "example@gmail.com",
                password: "example1234", password_confirmation: "example1234")
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
end
