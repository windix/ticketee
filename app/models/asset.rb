class Asset < ActiveRecord::Base
  belongs_to :ticket

  mount_uploader :asset, AssetUploader

  def content_type
    get_image_extension(asset.path)
  end

  private

  def get_image_extension(local_file_path)
    png = Regexp.new("\x89PNG".force_encoding("binary"))
    jpg = Regexp.new("\xff\xd8\xff\xe0\x00\x10JFIF".force_encoding("binary"))
    jpg2 = Regexp.new("\xff\xd8\xff\xe1(.*){2}Exif".force_encoding("binary"))
    case IO.read(local_file_path, 10)
    when /^GIF8/
      'gif'
    when /^#{png}/
      'png'
    when /^#{jpg}/
      'jpg'
    when /^#{jpg2}/
      'jpg'
    else
      mime_type = `file #{local_file_path} --mime-type`.gsub("\n", '') # Works on linux and mac
      raise UnprocessableEntity, "unknown file type" if !mime_type
      mime_type.split(':')[1].split('/')[1].gsub('x-', '').gsub(/jpeg/, 'jpg').gsub(/text/, 'txt').gsub(/x-/, '')
    end
  end
end
