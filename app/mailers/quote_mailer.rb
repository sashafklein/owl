class QuoteMailer < ActionMailer::Base
  def send_quote(user, quote)
    return unless user.email

    @quote = quote

    mail({
      to: user.email, 
      from: "#{quote.author} (Quote Owl) <postmaster@app27196200.mailgun.org>", 
      subject: quote.body.length > 100 ? quote.author : "#{quote.author} -- #{quote.body}"
    })
  end

  def confirm_delete(user, quote)
    return unless user.email

    @quote = quote
    mail(to: user.email, subject: "Deleted quote #{quote.id}", from: "Quote Owl <postmaster@app27196200.mailgun.org>")
  end

  def confirm_edit(user, quote, new_body)
    return unless user.email

    @author, @original, @edited = quote.author, quote, new_body
    mail(to: user.email, subject: "Edited quote #{quote.id}", from: "Quote Owl <postmaster@app27196200.mailgun.org>")
  end
end
