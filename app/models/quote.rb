class Quote < ActiveRecord::Base
  belongs_to :collection
  delegate :users, to: :collection

  validate :is_unique_for_collection

  def self.sent_the_fewest_times
    where(times_sent: min_times_sent)
  end

  def self.min_times_sent
    pluck(:times_sent).min || 0
  end

  def self.edit!(user, subject, body)
    if quote = Quote.find( pluck_id(subject, 'EDIT') )
      puts "---------- editing quote #{quote.id}"
      QuoteMailer.confirm_edit(user, quote, body).deliver_now
      quote.update_attribute(:body, body)
    end
  end

  def self.delete!(user, subject)
    if quote = Quote.find( pluck_id(subject, 'DELETE') )
      QuoteMailer.confirm_delete(user, quote).deliver_now
      quote.destroy
    end
  end

  def increment_times_sent!
    update_attribute(:times_sent, times_sent + 1)
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
