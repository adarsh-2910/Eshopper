namespace :sample do
  desc "Greeting to the team"
  task test: :environment do
    UserMailer.sendmail.deliver
  end
end
