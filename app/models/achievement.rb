class Achievement < ApplicationRecord
  belongs_to :user
  enum privacy: %i[public_access private_access friends_access]
  validates :title, presence: true

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(tescription)
  end
end
