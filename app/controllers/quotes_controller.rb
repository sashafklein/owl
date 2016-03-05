class QuotesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, only: [:handle]

  def handle
    sender    = params[:from]
    sender    = sender.split('<').last.split('>').first if sender.include?('<')
    subject    = params.fetch('subject', nil)
    body      = params.fetch('stripped-text', nil)

    if subject && body
      user = User.where(email: sender).first_or_create

      puts "SUBJECT: #{subject}"
      puts "BODY: #{body}"

      if subject.include?("DELETE")
        Quote.delete!(user, subject)
      elsif subject.include?("EDIT")
        Quote.edit!(user, subject, body)
      else 
        user.add_quote({author: subject, body: body})
      end
    end

    head 200
  end

end
