class Collection < ActiveRecord::Base
  has_many :quotes
  has_many :users

  def get_upcoming_quote!
    quote = quotes.sent_the_fewest_times.to_a.sample
    quote.increment_times_sent!
    quote
  end
end
