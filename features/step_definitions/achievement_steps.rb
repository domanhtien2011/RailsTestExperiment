Given('I am a guest user') do
end

Given('there is a public achievement') do
  @achievement = FactoryBot.create(:public_achievement, title: 'I am the toughest warrior in the history of human being!!!')
end

When("I go to the achievement's page") do
  visit(achievement_path(@achievement.id))
end

Then("I must see achievement's content") do
  expect(page).to have_content('I am the toughest warrior in the history of human being!!!')
end
