class Visit < ActiveRecord::Base
  attr_accessible :shortened_url, :user_id

  validates :user_id, :presence => true
  validates :shortened_url_id, :presence => true

  belongs_to :shortened_url
  belongs_to :visitor

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      :user_id => user.id,
      :shortened_url_id => shortened_url.id
    )
  end
end
