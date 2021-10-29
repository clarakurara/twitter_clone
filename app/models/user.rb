class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 50, minimum: 2}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 50, mimimum: 4},
                                      format: { with: VALID_EMAIL_REGEX },
                                      uniqueness: { case_sensitive: true }
                                      
    validates :password, length: { minimum: 6 }

    has_many :microposts, dependent: :destroy
# Followed Users
    has_many :active_relationships, foreign_key: "follower_id",
                                    class_name: "Relationship",
                                    dependent: :destroy
    has_many :followed_users, through: :active_relationships, source: :followed

    has_many :passive_relationships, foreign_key: "followed_id",
                                     class_name: "Relationship",
                                     dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower
    
    def feed
        Micropost.where("user_id = ?", id)
    end

    # returns true if the current user is following the other user
    def following?(other_user)
        active_relationships.find_by(followed_id: other_user.id)
    end
    # follows a user
    def follow(other_user)
        active_relationships.create!(followed_id: other_user.id)
    end
    # unfollows a user
    def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
    end
end