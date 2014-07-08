class QuotesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, only: [:create]
  
  def create
    sender    = params[:from]
    sender    = sender.split('<').last.split('>').first if sender.include?('<')
    author    = params.fetch('subject', nil)
    body      = params.fetch('stripped-text', nil)

    if author && body
      user = User.where(email: sender).first_or_create
      quote = user.quotes.where(author: author, body: body).first_or_create
    end

    head 200
  end

end
