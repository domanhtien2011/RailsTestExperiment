FactoryBot.define do
  factory :achievement do
    sequence(:title) { |n| "Achievement_#{n}" }
    tescription 'Nobody can stop me!!!'
    featured false
    conver_image 'ahihi...'

    factory :public_achievement do
      privacy :public_access
    end

    factory :private_achievement do
      privacy :private_access
    end
  end
end
