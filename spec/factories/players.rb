# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    factory(:alice){ name 'Alice' }
    factory(:bob)  { name 'Bob'   }
    factory(:eve)  { name 'Eve'   }
  end
end
