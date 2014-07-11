class User < ActiveRecord::Base
  has_many :quotes

  def get_upcoming_quote!
    quote = quotes.sent_the_fewest_times.to_a.sample
    quote.increment_times_sent!
    quote
  end
end
