class Listing < ActiveRecord::Base
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, 
	:default_url => "/images/:style/default.jpg",
	:storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  	
end
