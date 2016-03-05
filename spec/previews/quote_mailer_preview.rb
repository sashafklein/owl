class QuoteMailerPreview < ActionMailer::Preview
  def send_quote
    QuoteMailer.send_quote(User.first, Quote.all.sample(1).first)
  end
end