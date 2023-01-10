namespace :wishlist do
  desc "TODO"
  task test: :environment do
    UserMailer.wishlistmail_admin.deliver
  end
end
