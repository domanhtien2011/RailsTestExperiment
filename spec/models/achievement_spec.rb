require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
    it 'requires title' do
      achievement = Achievement.new(title: '')
      # achievement.valid?
      # expect(achievement.errors[:title]).to include("can't be blank")
      # expect(achievement.errors[:title]).not_to be_empty
      expect(achievement.valid?).to be_falsy
    end

    it 'requires title to be unique for one user' do
      user = FactoryBot.create(:user)
      first_achievement = FactoryBot.create(:public_achievement,
                                            title: 'First achievement',
                                            user: user)
      second_achievement = Achievement.new(title: 'First achievement',
                                           user: user)
      expect(second_achievement.valid?).to be_falsy
    end

    it 'allows different users to have identical titles' do
      user1             = FactoryBot.create(:user)
      user2             = FactoryBot.create(:user)
      first_achievement  = FactoryBot.create(:public_achievement,
                                             title: 'First achievement',
                                             user: user1)
      second_achievement = Achievement.new(title: 'First achievement',
                                           user: user2)
      expect(second_achievement.valid?).to be_truthy
    end

    it 'belongs to a user' do
      achievement = Achievement.new(title:
      'I am the toughest and smartest Navy SEALS',
                                    user: nil)
      expect(achievement.valid?).to be_falsy
    end

    # it 'has belong_to user association' do
    #   # 1st approach
    #   user = FactoryBot.create(:user)
    #   achievement = FactoryBot.create(:public_achievement, user: user)
    #   expect(achievement.user).to eq(user)

    #   # 2nd approach
    #   u = Achievement.reflect_on_association(:user)
    #   expect(u.macro).to eq(:belongs_to)
    # end

    it { should belong_to(:user) }
  end
end
