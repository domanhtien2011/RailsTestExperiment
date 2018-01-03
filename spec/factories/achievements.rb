FactoryBot.define do
  factory :achievement do
    sequence(:title) {|n| "Achievement_#{n}"}
    tescription 'Nobody can stop me!!!'
    privacy Achievement.privacies[:private_access]
    featured false
    conver_image 'ahihi...'

    factory :public_achievement do
      privacy Achievement.privacies[:public_access]
    end
  end
end
