class User < ActiveRecord::Base
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :description, :name, :location, :school, :username
  # attr_accessible :title, :body

  has_many :courses, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :units,   :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :lessons, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :assessments, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :vocabulary_lists, :foreign_key => "user_id",
                     :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :comments, :as => :commentable
  has_many :authored_comments, class_name: "Comment"
  has_many :favorites, :as => :favorable
  has_many :authored_favorites, class_name: "Favorite", :foreign_key => "favorer"


  friendly_id :username, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def favorable(opts={})
  
    # favorable_type
    type = opts[:type] ? opts[:type] : :topic
    type = type.to_s.capitalize

    # add favorable_id to condition if id is provided
    con = ["user_id = ? AND favorable_type = ?", self.id, type]
  
    # append favorable id to the query if an :id is passed as an option into the
    # function, and then append that id as a string to the "con" Array
    if opts[:id]
      con[0] += " AND favorable_id = ?"
      con << opts[:id].to_s
    end
 
    # Return all Favorite objects matching the above conditions
    favs = Favorite.all(:conditions => con)
  
    case opts[:delve]
    when nil, false, :false
      return favs
    when true, :true
      # get a list of all favorited object ids
      fav_ids = favs.collect{|f| f.favorable_id.to_s}

      if fav_ids.size > 0
        # turn the Capitalized favorable_type into an actual class Constant
        type_class = type.constantize

        # build a query that only selects
        query = []
        fav_ids.size.times do
          query << "id = ?"
        end
        type_conditions = [query.join(" AND ")] + fav_ids

        return type_class.all(:conditions => type_conditions)
      else
        return []
      end
    end
  end      
end