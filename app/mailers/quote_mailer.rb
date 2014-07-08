class QuoteMailer < ActionMailer::Base
  default from: "Quote Owl <postmaster@app27196200.mailgun.org>"

  def deliver_random_quote!(user)
    return unless user && user.email && user.quotes.any?

    @quote = user.quotes.to_a.sample
    mail(to: user.email, subject: @quote.author)
  end
end
