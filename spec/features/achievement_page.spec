require 'rails_helper'

feature 'achievement page' do
  scenario 'achievement public age' do
    achievement = FactoryBot.create(:achievement, title: 'Just read a book')
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('Just read a book')
  end

  scenario 'render markdown description' do
    achievement = FactoryBot.create(:achievement, tescription: 'That *was* hard')
    visit("/achievements/#{achievement.id}")

    expect(page).to have_content('<em>was</em>')
  end
end
