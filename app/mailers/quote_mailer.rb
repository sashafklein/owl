class QuoteMailer < ActionMailer::Base
  default from: "Quote Owl <postmaster@app27196200.mailgun.org>"

  def deliver_random_quote(user)
    return unless user && user.email && user.quotes.any?

    @quote = user.get_upcoming_quote!
    mail(to: user.email, subject: @quote.author)
  end
end
