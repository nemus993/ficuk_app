require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let(:user) do
    User.create(first_name: "John", last_name: "Doe",
                birthday: "1960-08-08", email: "example@gmail.com",
                password: "example1234", password_confirmation: "example1234", mentions: 0)
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
  it 'can have mentions to other users' do
    tweet.content = "I'm mentioning other @user!"
    expect(tweet.has_mention).to be true
  end
  it 'returns first_name for mention' do
    tweet.content = "I'm mentioning @john"
    expect(tweet.mentioned).to eq("John")
  end
  it 'add mention count to correct user' do
    tweet.content = "I'm chilling with @john!"
    tweet.add_mention
    expect(user.mentions).to eq(1)
  end
end
