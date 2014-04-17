u1 = User.create!(email: "cwhite@gmail.com")
u2 = User.create!(email: "bwarford@gmail.com")

su1 = ShortenedUrl.create_for_user_and_long_url!(
  u1, "www.google.com",
)

su2 = ShortenedUrl.create_for_user_and_long_url!(
  u2, "www.google2.com",
)
