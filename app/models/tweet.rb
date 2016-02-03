class Tweet < ActiveRecord::Base
  validates :content, length: { minumum: 1, maximum: 160 }, presence: true
  belongs_to :user

  after_create :add_mention

  #adds mention to correct user
  def add_mention
    if self.has_mention
      mentioned_user = User.find_by(first_name: self.mentioned)
      mentioned_user.increment!(:mentions)
      mentioned_user.save
    end
  end
  #checks if tweet has mention in it
  def has_mention
    reg = /\B@[a-z0-9_-]+/
    !!(content.match(reg))
  end
  #return first_name of mentioned user
  def mentioned
    content.gsub /\B@[a-z0-9_-]+/ do |name|
       return name.gsub('@','').capitalize
    end
  end
end
