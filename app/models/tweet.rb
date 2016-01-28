class Tweet < ActiveRecord::Base
  validates :content, length: { minumum: 1, maximum: 160 }, presence: true
  belongs_to :user
end
