class ShortenedUrl < ActiveRecord::Base
  validates :long_url, :short_url, :submitter, presence: true
  validates :short_url, uniqueness: true

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id
  )

  has_many :visits, inverse_of: :shortened_url
  has_many :visitors, -> { distinct }, through: :visits

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      submitter: user,
      long_url: long_url,
      short_url: ShortenedUrl.random_code
    )
  end

  def self.random_code
    loop do
      random_code = SecureRandom.urlsafe_base64(16)
      return random_code unless ShortenedUrl.exists?(short_url: random_code)
    end
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    now = Time.now
    range = ((now - 10.minutes)..now)
    visits.select('DISTINCT user_id').where(created_at: range).count
  end
end
