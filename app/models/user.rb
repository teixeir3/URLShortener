class User < ActiveRecord::Base
  validates :email, :uniqueness => true, :presence => true

  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => "submitter_id"
  )

  has_many :visits

  has_many(
    :visited_urls,
    :through => :visits,
    :source => :shortened_url
  )
end

