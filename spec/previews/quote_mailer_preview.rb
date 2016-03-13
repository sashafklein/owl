class QuoteMailerPreview < ActionMailer::Preview
  def send_quote
    QuoteMailer.send_quote(User.first, Quote.find(99))
  end

  def confirm_delete
    QuoteMailer.confirm_delete(User.first, random_quote)
  end

  def confirm_edit
    QuoteMailer.confirm_edit(User.first, random_quote, "#{random_quote.body}. And I've been edited!")
  end

  private

  def random_quote
    @random_quote ||= Quote.all.sample(1).first
  end
end