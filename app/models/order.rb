class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type
  PAYMENT_TYPES = ["Check", "Credit card", "Purchase order" ]
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  has_many :line_items, dependent: :destroy
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
	item.cart_id = nil
	line_items << item
     end
   end

 def post_twitter(message)
    Twitter.configure do |config|
        config.consumer_key = User::CONSUMER_KEY
        config.consumer_secret = User:: CONSUMER_SECRET
        config.oauth_token = '1544574674-fKXHqwOcU3oSmNhRXVZONIKgdUvoGUnqZSFETP6'
        config.oauth_token_secret = 'YOTrfmJZzVf80fM9pQ3mBEP9Nw66o4o4KAvDWPOcOQ'
     end
   client = Twitter::Client.new
   begin
        client.update(message)
        return true
   rescue Exception => e
        self.errors.add(:name, "Unable to send")
        return false
   end
 end
 
end
