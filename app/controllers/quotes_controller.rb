class QuotesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, only: [:handle]

  def handle
    sender    = params[:from]
    sender    = sender.split('<').last.split('>').first if sender.include?('<')
    subject    = params.fetch('subject', nil)
    body      = params.fetch('stripped-text', nil)

    puts "RECEIVING:   "
    puts "---------- #{sender}"
    puts "---------- #{subject}"
    puts "---------- #{body}"
    if subject && body
      user = User.where(email: sender).first_or_create

      puts "SUBJECT: #{subject}"
      puts "BODY: #{body}"

      if subject.include?("DELETE")
        puts "---------- in delete"
        Quote.delete!(user, subject)
      elsif subject.include?("EDIT")
        puts "---------- in edit"
        Quote.edit!(user, subject, body)
      else 
        puts "---------- in adding"
        user.add_quote({author: subject, body: body})
      end
    end

    head 200
  end

end
