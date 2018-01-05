FactoryBot.define do
  factory :achievement do
    sequence(:title) { |n| "Achievement_#{n}" }
    tescription 'I am the smartest and toughest warrior in the history of human beings...'
    featured false
    conver_image 'cover_image.png'

    factory :public_achievement do
      privacy :public_access
    end

    factory :private_achievement do
      privacy :private_access
    end
  end
end
