class QuoteMailer < ActionMailer::Base

  QUOTE_OWL = "Quote Owl <postmaster@app27196200.mailgun.org>"
  
  def send_quote(user, quote)
    return unless user.email

    @quote = quote

    display_in_subject = quote.body.length < 100

    mail({
      to: user.email, 
      from: display_in_subject ? "#{quote.author.gsub(/[\,'."\(\)#]/, '')} - #{QUOTE_OWL}" : QUOTE_OWL, 
      subject: display_in_subject ? quote.body : quote.author
    })
  end

  def confirm_delete(user, quote)
    return unless user.email

    @quote = quote
    mail(to: user.email, subject: "Deleted quote #{quote.id}", from: QUOTE_OWL)
  end

  def confirm_edit(user, quote, new_body)
    return unless user.email

    @author, @original, @edited = quote.author, quote, new_body
    mail(to: user.email, subject: "Edited quote #{quote.id}", from: QUOTE_OWL)
  end
end
