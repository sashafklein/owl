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

  def increment_times_sent!
    update_attribute(:times_sent, times_sent + 1)
  end

  private

  def is_unique_for_collection
    return errors.add(:collection, "can't be blank.") unless collection

    if collection.quotes.find_by(author: author, body: body)
      errors.add(:author_and_body, "can't be already taken")
    end
  end
end
