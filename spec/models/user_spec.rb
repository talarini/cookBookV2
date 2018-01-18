require 'rails_helper'

  RSpec.describe '#favorited?' do
    it 'user favorited recipe' do
      user = create(:user)
      recipe = create(:recipe, user:user)
      Favorite.create(recipe: recipe, user:user)

      fav = user.favorited? recipe

      expect(fav).to be true
    end
    it 'user can favorite recipe' do
      user = create(:user)
      recipe = create(:recipe, user:user)

      fav = user.favorited? recipe

      expect(fav).to be false
    end
    it 'invalid recipe' do
      user = create(:user)

      fav = user.favorited? nil

      expect(fav).to be false
    end
  end

  RSpec.describe '#my_recipe?' do
    it 'user is the recipe owner' do
      user = create(:user)
      recipe = create(:recipe, user:user)

      owner = user.my_recipe? recipe

      expect(owner).to be true
    end
    it 'user is not the recipe owner' do
      user = create(:user)
      another_user =  create(:user, email:'email2@email.com')
      recipe = create(:recipe, user:another_user)

      owner = user.my_recipe? recipe

      expect(owner).to be false
    end
  end
