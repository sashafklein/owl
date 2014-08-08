class User < ActiveRecord::Base
  belongs_to :collection
  has_many :quotes, through: :collection

  def add_quote(opts={})
    quote = Quote.new(
      author: opts[:author],
      body: opts[:body],
      times_sent: quotes.min_times_sent,
      collection: collection
    )
    quote.save
    quote
  end
end
