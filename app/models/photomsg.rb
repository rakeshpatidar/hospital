class Photomsg < ActiveRecord::Base
  #attr_accessible :photomsg, :image_data, :image
  attr_accessor :image_data

	has_attached_file :image, 
                    :styles => {medium: ["300x300>", :png], thumb: ["100x100>", :png]},
                    :storage => :s3
                    
                    
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
	before_save :decode_image_data
def image_url
    image.url(:original)
    end
	def decode_image_data
    # If image_data is present, it means that we were sent an image over
    # JSON and it needs to be decoded.  After decoding, the image is processed
    # normally via Paperclip.
    if self.image_data.present?
        data = StringIO.new(Base64.decode64(self.image_data))
        data.class.class_eval {attr_accessor :original_filename, :content_type}
        data.original_filename = self.id.to_s + ".png"
        data.content_type = "image/png"

        self.image = data
    end
  end
  def created_at=(val)
  Date.strptime(val, "%d/%m/%Y") if val.present?
end
end
