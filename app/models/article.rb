class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
  before_validation :nillify_parameters,
                    :set_default_author
                    
  scope :troll, -> { where(author: "J. Trollington") } # method can be used in database query
  
  def default_author
    if author 
      author 
    else
      'joe'
    end  
  end
  
  private
    def nillify_parameters
    
      arr = ["text", "author"]
      arr.each do |x|
        if send(x) == ""
          send("#{x}=", nil)
        end
      end
    end
    
    def set_default_author
      if author == "test"
        self.author = "J. Bloggs"
      end
    end
  
end
