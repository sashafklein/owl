task :send_quotes => :environment do 
  User.all.each do |user|
    QuoteMailer.deliver_random_quote(user).deliver
  end
end
