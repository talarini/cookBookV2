FactoryBot.define do
  factory :recipe do
    title 'Bolo'
    difficulty 'Fácil'
    ingredients 'Farinha, ovo, manteiga, acucar'
    cook_time 60
    add_attribute(:method) { 'Misturar tudo e assar' }
    cuisine
    recipe_type
    user
  end
end
