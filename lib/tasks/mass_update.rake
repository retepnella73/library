desc "Loads all discs, and then saves them all in order to create sort_artist attribute"
task :mass_update_discs => :environment do
  discs = Disc.all
  discs.each do |d|
    d.save!
  end
end

desc "Loads all books, and then saves them all in order to create sort_author attribute"
task :mass_update_books => :environment do
  books = Book.all
  books.each do |b|
    b.save!
  end
end

