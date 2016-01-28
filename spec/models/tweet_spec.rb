require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:user) do
    User.create(first_name: "John", last_name: "Doe",
                birthday: "1960-08-08", email: "example@gmail.com",
                password: "example1234", password_confirmation: "example1234")
  end
  let(:tweet) do
    Tweet.create( content: "This is example tweet", user_id: user.id )
  end

  it 'is valid' do
    expect(tweet).to be_valid
  end
  it 'is associated with user' do
    expect(tweet).to respond_to(:user)
  end
  it 'is invalid without content' do
    tweet.content = nil
    expect(tweet).not_to be_valid
  end
  it 'is invalid if over 160 characters' do
    tweet.content = "QWERTY QWERTY qwerty qwerty qwerty qwerty qwerty qwerty qwerty qwerty
                     qwerty qwerty qwerty qwerty qwerty qwerty qwerty qwerty qwerty qwerty
                     qwerty qwerty qwerty qwerty qwerty qwerty qwerty qwerty"
    expect(tweet).not_to be_valid
  end
end
