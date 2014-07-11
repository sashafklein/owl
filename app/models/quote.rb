class Quote < ActiveRecord::Base
  belongs_to :user

  def self.sent_the_fewest_times
    min_times_sent = pluck(:times_sent).min
    self.where(times_sent: min_times_sent)
  end

  def increment_times_sent!
    update_attribute(:times_sent, times_sent + 1)
  end
end
