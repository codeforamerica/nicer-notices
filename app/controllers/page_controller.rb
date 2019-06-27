class PageController < ApplicationController
  def dashboard
  end

  def example
  end

  def send_example
    api_instance = ClickSendClient::PostLetterApi.new

    # PostLetter | PostLetter model
    post_letter = ClickSendClient::PostLetter.new(
      "file_url": request.base_url + "/letter.pdf",
      "colour": 0,
      "recipients": [
        {
          "return_address_id": 69578,
          "schedule": 0,
          "address_postal_code": "94103",
          "address_country": "US",
          "address_line_1": "972 Mission St",
          "address_state": "CA",
          "address_name": params[:name],
          "address_line_2": "5th Floor",
          "address_city": "San Francisco"
        }
      ],
      "template_used": 0,
      "duplex": 0,
      "priority_post": 0,
      "source": "sdk"
    )
  
    begin
      # Send post letter
      result = api_instance.post_letters_send_post(post_letter)
      p JSON.parse(result)
    rescue ClickSendClient::ApiError => e
      puts "Exception when calling PostLetterApi->post_letters_send_post: #{e}"
    end
  
    api_instance = ClickSendClient::TransactionalEmailApi.new

    email = ClickSendClient::Email.new # Email | Email model

    email.to = [
        ClickSendClient::EmailRecipient.new("name": params[:name], "email": params[:email]),
    ]
    email.from = ClickSendClient::EmailFrom.new(
        "name": "Code for America",
        "email_address_id": 5997
    )

    email.subject = "Six Month Renewal for SNAP"

    email.body = "<p>Hello!</p>
        <p>A friendly reminder to fill out your Semi-Annual Report (SAR). Submit it by <strong>January 11</strong> to make sure you get your Pennsylvania SNAP EBT benefits on time next month. Do it online at <a href='https://www.compass.state.pa.us'>https://www.compass.state.pa.us</a>.</p>
        <p>Your ever-helpful public servants,
        Penssylvania Health and Human Services</p>"

    begin
      # Send transactional email
      result = api_instance.email_send_post(email)
      p JSON.parse(result)
    rescue ClickSendClient::ApiError => e
      puts "Exception when calling TransactionalEmailApi->email_send_post: #{e.response_body}"
    end

    api_instance = ClickSendClient::SMSApi.new
  
    # SmsMessageCollection | SmsMessageCollection model
    sms_messages = ClickSendClient::SmsMessageCollection.new
  
    sms_messages.messages = [
        ClickSendClient::SmsMessage.new(
            "to": "+1" + params[:phone],
            "source": "sdk",
            "body": "Hello! A friendly reminder to fill out your Semi-Annual Report (SAR). Submit it by January 11 to make sure you get your Pennsylvania SNAP EBT benefits on time next month. Do it online at https://www.compass.state.pa.us"
        )
    ]
    begin
      # Send sms message(s)
      result = api_instance.sms_send_post(sms_messages)
      p JSON.parse(result)
    rescue ClickSendClient::ApiError => e
      puts "Exception when calling SMSApi->sms_send_post: #{e.response_body}"
    end

    return 200
  end
end
