class Visit < ActiveRecord::Base
  validates :visitor, :shortened_url, presence: true

  belongs_to :shortened_url, inverse_of: :visits
  belongs_to(
    :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'
  )

  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor: user, shortened_url: shortened_url)
  end
end
