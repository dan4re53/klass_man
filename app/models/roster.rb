class Roster < ActiveRecord::Base
  has_many :users
  belongs_to :user #:teacher, class_name: "User", foreign_key: "admin_id"
  validates :user_id, presence: true
  validates :description, presence: true
  def add_student(user_id)
    Roster.new(user_id: user_id)
  end
end
