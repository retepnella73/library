desc "Loads all discs, and then saves them all in order to create sort_artist attribute"
task :mass_update_discs => :environment do
  discs = Disc.all
  discs.each do |d|
    d.save!
  end
end
