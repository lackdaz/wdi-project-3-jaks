module SendEmail

  def send_message(recipient_name, recipient_email, subject, body)
    RestClient.post "https://api:key-ad023b7d475cfd71c68cea721f5df942"\
    "@api.mailgun.net/v3/sandboxc407848f666d4e12bba2b5133011dd1f.mailgun.org/messages",
    :from => "Ice Scream! <postmaster@sandboxc407848f666d4e12bba2b5133011dd1f.mailgun.org>",
    :to => recipient_name + " <" + recipient_email + ">",
    :subject => subject,
    :text => body
  end

end
