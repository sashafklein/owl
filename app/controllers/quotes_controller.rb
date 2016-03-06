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

      if subject.include?("DELETE")
        puts "---------- deleting"
        Quote.delete!(user, subject)
      elsif subject.include?("EDIT")
        puts "---------- editing"
        Quote.edit!(user, subject, body)
      else 
        puts "---------- adding"
        user.add_quote({author: subject, body: body})
      end
    end

    head 200
  end

end
