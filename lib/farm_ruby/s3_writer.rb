class S3Writer
  def initialize(region, bucket_name, file_name,
                 key = ENV['AWS_ACCESS_KEY_ID'], secret = ENV['AWS_SECRET_ACCESS_KEY'],
                 pretty: false)
    ENV['AWS_ACCESS_KEY_ID'] ||= key
    ENV['AWS_SECRET_ACCESS_KEY'] ||= secret
    @bucket_name = bucket_name
    @region = region
    @file_name = file_name
  end

  def write(&block)
    bucket.object(@file_name).put(body: block.call)
    puts "#{@file_name} WRITTEN TO S3:#{@region}/#{@bucket_name}"
  end

  private

  def resource
    @recource ||= Aws::S3::Resource.new(:region => @region)
  end

  def bucket
    @bucket ||= resource.bucket(@bucket_name)
  end
end
