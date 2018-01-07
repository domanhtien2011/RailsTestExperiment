require 'rails_helper'

RSpec.describe Achievement, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user) }
    it {
      should validate_uniqueness_of(:title)
        .scoped_to(:user_id)
        .with_message("You can't have two achievements with the same title")
    }
    it { should belong_to(:user) }
    it 'converts markdown to html' do
      achievement = Achievement.new(tescription:
       'Awesome **thing** I *actually* did')
      expect(achievement.description_html).to include('<strong>thing</strong>')
      expect(achievement.description_html).to include('<em>actually</em>')
    end

    it 'has silly title' do
      achievement = Achievement.new(title:
       'I am the smartest and toughest NAVY SEAL',
                                    user:
                                    FactoryBot
                                    .create(:user,
                                            email: 'best_navy_seal@gmail.com'))
      expect(achievement.silly_title).to eq(
        'I am the smartest and toughest NAVY SEAL by best_navy_seal@gmail.com'
      )
    end

    it 'only fetches achievements which title starts from provided letter' do
      user         = FactoryBot.create(:user)
      achievement1 = FactoryBot
                     .create(:public_achievement,
                             title:
                             'I am the smartest and toughest NAVY SEALS',
                             user: user)
      achievement2 = FactoryBot.create(:public_achievement,
                                       title: 'Nobody can stop me', user: user)
      expect(Achievement.by_letter('I')).to eq([achievement1])
    end

    it 'sorts achievement by user emails' do
      albert       = FactoryBot.create(:user, email: 'albert@email.com')
      rob          = FactoryBot.create(:user, email: 'rob@email.com')
      achievement1 = FactoryBot.create(:public_achievement,
                                       title: 'I am confident in myself',
                                       user: rob)
      achievement2 = FactoryBot.create(:public_achievement,
                                       title: 'I believe in my fate',
                                       user: albert)
      expect(Achievement.by_letter('I')).to eq([achievement2, achievement1])
    end

    # it 'requires title' do
    #   achievement = Achievement.new(title: '')
    #   # achievement.valid?
    #   # expect(achievement.errors[:title]).to include("can't be blank")
    #   # expect(achievement.errors[:title]).not_to be_empty
    #   expect(achievement.valid?).to be_falsy
    # end

    # it 'requires title to be unique for one user' do
    #   user = FactoryBot.create(:user)
    #   first_achievement = FactoryBot.create(:public_achievement,
    #                                         title: 'First achievement',
    #                                         user: user)
    #   second_achievement = Achievement.new(title: 'First achievement',
    #                                        user: user)
    #   expect(second_achievement.valid?).to be_falsy
    # end

    # it 'allows different users to have identical titles' do
    #   user1             = FactoryBot.create(:user)
    #   user2             = FactoryBot.create(:user)
    #   first_achievement  = FactoryBot.create(:public_achievement,
    #                                          title: 'First achievement',
    #                                          user: user1)
    #   second_achievement = Achievement.new(title: 'First achievement',
    #                                        user: user2)
    #   expect(second_achievement.valid?).to be_truthy
    # end

    # it 'belongs to a user' do
    #   achievement = Achievement.new(title:
    #   'I am the toughest and smartest Navy SEALS',
    #                                 user: nil)
    #   expect(achievement.valid?).to be_falsy
    # end

    # it 'has belong_to user association' do
    #   # 1st approach
    #   user = FactoryBot.create(:user)
    #   achievement = FactoryBot.create(:public_achievement, user: user)
    #   expect(achievement.user).to eq(user)

    #   # 2nd approach
    #   u = Achievement.reflect_on_association(:user)
    #   expect(u.macro).to eq(:belongs_to)
    # end
  end
end
