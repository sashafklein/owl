class QuoteMailer < ActionMailer::Base
  default from: "Quote Owl <postmaster@app27196200.mailgun.org>"

  def send_quote(user, quote)
    return unless user.email

    @quote = quote

    mail(to: user.email, subject: @quote.author)
  end
end
