require 'csv'    

desc "Imports a CSV file into an ActiveRecord table"
task :csv_model_import, :filename do |task,args|

  csv_text = File.read(args[:filename])
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Artist.create!(row.to_hash)
  end
end
