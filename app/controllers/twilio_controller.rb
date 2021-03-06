require 'twilio-ruby'

class TwilioController < ApplicationController
  before_action :authenticate_request

  def call
    begin
      account_sid = ENV['TWILIO_KEY']
      auth_token = ENV['TWILIO_SECRET']

      @client = Twilio::REST::Client.new account_sid, auth_token
      @message = "Hi #{params[:user_name]}. Please take your Anxiety Survey. http://empower-you.herokuapp.com"
      message = @client.account.messages.create(:body => @message,
      :to => params[:phone_number],
      :from => "+17209438130")
      render json: {  success: 'Success: The reminder SMS has been sent.' }
      puts message
    rescue Twilio::REST::RequestError => e
      puts e.message
      render json: { error: 'Problem occured: Please try again later.' }
    end
  end
end
