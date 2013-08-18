class ShortenedUrl < ActiveRecord::Base
  attr_accessible(
    :long_url,
    :short_url,
    :submitter_url
  )

  validates :long_url, :presence => true, :uniqueness => true
  validates :short_url, :presence => true, :uniqueness => true
  validates :submitter_id, :presence => true

  belongs_to(
    :submitter,
    :class_name => "User",
    :foreign_key => "submitter_id"
  )

  has_many :visits
  # `:unique => true` means a `User` will be returned only once no
  # matter how many times they click.
  has_many :visitors, :through => :visits, :unique => true

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      :submitter_id => user.id,
      :long_url => long_url,
      :short_url => ShortenedUrl.random_code
    )
  end

  def self.random_code(long_url)
    while true do
      random_code = SecureRandom.urlsafe_base64(16)
      return random_code if !ShortenedUrl.where(:short_url => short_url).exists?
    end
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.count(:user_id, :distinct => true)
  end

  def num_recent_uniques
    now = Time.now
    range = ((now - 10.minutes)..now)
    visits.where(:created_at => range).count(:user_id, :distinct => true)
  end
end
