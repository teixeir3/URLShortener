class Visit < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :shortened_url_id, :presence => true

  belongs_to :shortened_url
  belongs_to :visitor,
             :primary_key => :id,
             :foreign_key => :user_id,
             :class_name => "User"

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      :user_id => user.id,
      :shortened_url_id => shortened_url.id
    )
  end
end

