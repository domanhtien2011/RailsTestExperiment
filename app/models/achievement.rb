class Achievement < ApplicationRecord
  belongs_to :user
  enum privacy: %i[public_access private_access friends_access]
  validates :title, presence: true
  validates_presence_of :user,
                        on: :create,
                        message: "can't be blank"
  validates_uniqueness_of :title,
                          scope: :user_id,
                          message:
                          "You can't have two achievements with the same title"

  # validate :unique_title_for_one_user

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(tescription)
  end

  def silly_title
    title + ' by ' + user.email
  end

  def self.by_letter(letter)
    includes(:user).where('title LIKE ?', "#{letter}%").order('users.email')
  end

  # private

  # def unique_title_for_one_user
  #   existing_achievement = Achievement.find_by(title: title)
  #   return if !existing_achievement || existing_achievement.user != user
  #   errors.add(:title, 'You cannot have two achievements with the same title')
  # end
end
