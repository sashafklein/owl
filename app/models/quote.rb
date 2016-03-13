class Quote < ActiveRecord::Base
  include ActionView::Helpers::TagHelper

  belongs_to :collection
  delegate :users, to: :collection

  validate :is_unique_for_collection

  def self.run_editor
    all.find_each do |quote|
      puts quote.body
      puts "Remove spaces?"
      response = gets.chomp
      go = response.downcase.include?('y')
      if go
        quote.update_attribute(:body, quote.body.gsub("\r\n", ' '))
        puts quote.reload.body
      end
    end
  end

  def self.sent_the_fewest_times
    where(times_sent: min_times_sent)
  end

  def self.min_times_sent
    pluck(:times_sent).min || 0
  end

  def self.edit!(user, subject, body)
    if quote = Quote.find( pluck_id(subject, 'EDIT') )
      QuoteMailer.confirm_edit(user, quote, boldify(body)).deliver_now
      quote.update_attribute(:body, body)
    end
  end

  def self.delete!(user, subject)
    if quote = Quote.find( pluck_id(subject, 'DELETE') )
      QuoteMailer.confirm_delete(user, quote).deliver_now
      quote.destroy
    end
  end

  def self.boldify(quote) 
    quote.gsub(/(?:\*+)([a-zA-Z0-9 ]+)(?:\*+)/) { "<strong>#{$1}</strong>" }
  end

  def increment_times_sent!
    update_attribute(:times_sent, times_sent + 1)
  end

  def display_body
    Quote.boldify(body)
  end

  private

  def self.pluck_id(subject, action_string) 
    subject.split(action_string)[1].gsub(':', '').gsub('-', '').strip
  end

  def is_unique_for_collection
    return errors.add(:collection, "can't be blank.") unless collection

    if collection.quotes.find_by(author: author, body: body)
      errors.add(:author_and_body, "can't be already taken")
    end
  end
end
