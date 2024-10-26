require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

bucket_name = ENV['BUCKET_NAME']


client = Aws::S3::Client.new

resp = client.create_bucket({
  bucket: bucket_name, 
  create_bucket_configuration: {
    location_constraint: "us-west-1", 
  }, 
})

number_of_files = 1+ rand(6)
puts "number of files: #{number_of_files}"

number_of_files.times.each do |i|
    puts "i: #{i}
    filename = "file_#{i}.txt"
    output_path = "/tmp/#{filename}"
    File.open(output_path, "w") do |f|
        f.write securerandom.uuid
    end
    File.open(output_path, 'rb') do |file|
        s3.put_object(bucket: bucket_name, key: filename, body: f)
    end
end

