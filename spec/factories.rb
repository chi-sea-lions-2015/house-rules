FactoryGirl.define do


  facotry :user do
    first_name "Paul"
    last_name "Clegg"
    email "paul@paul.com"
    password "123456"
  end

  factory :address do
    street "1462 W Carmen Ave Apt 2"
    city "Chicago"
    state "IL"
    zip_code "60640"
  end

  factory :property_manager do
    name "Tom"
    phone "773-606-6186"
    email "tom@tom.com"
    address
  end

  factory :house do
    name "The hater house"
    address
    property_manager
  end

  factory :housing_assignment do
    user
    house
  end

  factory :rule do
    content "Flush damnit!"
    housing_assignment
  end

  factory :chore do
    task "do dishes"
    house
  end

  factory :chore_log do
    user
    chore
  end

  factory :event do
    name "halloween"
    date "2013-09-12 22:49:27"
    description "Costume party!!"
    housing_assignment
  end

  factory :communal_item do
    name "toilet paper"
    house
    stock_level "low"
  end

  factory :messages do
    content "you're the best"
    housing_assignment
  end

  factory :issue do
    reason "you suck"
    user

end