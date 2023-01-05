namespace :sample do
  desc "Greeting to the team"
  task test: :environment do
    UserMailer.sendmail(order_details).deliver
  end
end
