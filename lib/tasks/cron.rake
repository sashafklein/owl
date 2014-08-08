task :send_quotes => :environment do 
  Collection.find_each do |collection|
    quote = collection.get_upcoming_quote!
    collection.users.each do |user|
      QuoteMailer.send_quote(user, quote).deliver
    end
  end
end
