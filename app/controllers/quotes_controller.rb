class QuotesController < ApplicationController
  
  skip_before_filter :verify_authenticity_token, only: [:create]
  
  def create
    raise StandardError.new(params)
    head 200
  end
end