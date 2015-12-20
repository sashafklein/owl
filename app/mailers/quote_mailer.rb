class QuoteMailer < ActionMailer::Base
  default from: "Quote Owl <postmaster@app27196200.mailgun.org>"

  def send_quote(user, quote)
    return unless user.email

    @quote = quote

    mail(to: user.email, subject: @quote.author)
  end

  def confirm_delete(user, quote)
    return unless user.email

    @quote = quote
    mail(to: user.email, subject: "Deleted quote")
  end

  def confirm_edit(user, author, original, edited)
    return unless user.email

    @author, @original, @edited = author, original, edited
    mail(to: user.email, subject: "Edited quote")
  end
end
