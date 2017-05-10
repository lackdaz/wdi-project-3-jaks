# require 'rest-client'
#
# def send_simple_message
#     RestClient.post "https://api:key-ad023b7d475cfd71c68cea721f5df942"\
#         "@api.mailgun.net/v3/sandboxc407848f666d4e12bba2b5133011dd1f.mailgun.org/messages",
#         :from => "Mailgun Sandbox <postmaster@sandboxc407848f666d4e12bba2b5133011dd1f.mailgun.org>",
#         :to => "kenneth <kennth.gzhao@gmail.com>",
#         :subject => "Hello kenneth",
#         :text => "Congratulations kenneth, you just sent an email with Mailgun!  You are truly awesome!"
# end
#
# send_simple_message
