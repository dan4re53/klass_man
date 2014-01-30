FactoryGirl.define do
  factory :user do
    name                    "Daniel Kim"
    email                   "dk@example.com"
    password                "foobar"
    password_confirmation   "foobar"
  end
end