class QuoteMailer < ActionMailer::Base
  def send_quote(user, quote)
    return unless user.email

    @quote = quote

    display_in_subject = quote.body.length < 100

    mail({
      to: user.email, 
      from: "#{quote.author.gsub(/[\,'."\(\)#]/, '')} - Quote Owl <postmaster@app27196200.mailgun.org>", 
      subject: display_in_subject ? quote.body : quote.author
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
