FactoryBot.define do
  factory :user do
    nickname 'UserNickname'
    firstname 'FisrtUserName'
    second_name 'SecondUserName'
    email 'emailUser@email.com'
    password 'user-password'
    confirmed_at DateTime.now
  end

  factory :organization do
    name 'Organization'
    description 'Organization description'
  end
end
