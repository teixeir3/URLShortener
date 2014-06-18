require 'spec_helper'

describe ShortenedUrl do
  let!(:submitter) { User.first }
  let!(:visitor) { User.last }

  subject(:url) do
    ShortenedUrl.create!(
      submitter: submitter,
      long_url: "http://testing.com/tests",
      short_url: SecureRandom.hex
    )
  end

  before(:each) do
    url.visits.create!(visitor: submitter, created_at: 5.days.ago)
    url.visits.create!(visitor: visitor)
    url.visits.create!(visitor: visitor)
    url.visits.create!(visitor: visitor)
  end

  it 'counts the number of clicks' do
    expect(url.num_clicks).to eq(4)
  end

  it 'counts the number of uniques' do
    expect(url.num_uniques).to eq(2)
  end

  it 'counts the number of recent uniques' do
    expect(url.num_recent_uniques).to eq(1)
  end
end
