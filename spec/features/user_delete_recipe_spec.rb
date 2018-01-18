require 'rails_helper'

  feature 'user destroy recipe' do
    scenario 'succesfully' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      sign_in user

      visit root_path
      click_on recipe.title

      click_on 'Remover Receita'

      expect(current_path).to eq(root_path)
      expect(page).not_to have_link(recipe.title)
  end

    scenario 'visitor cant see destroy recipe button' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      visit root_path
      click_on recipe.title

      expect(page).not_to have_link('Remover Receita')
    end

    scenario 'user cant delete another users recipes' do
      user = create(:user)
      another_user = create(:user, email:'anotheremail@email.com')
      recipe = create(:recipe, user: user)

      sign_in another_user

      visit root_path
      click_on recipe.title

      expect(page).not_to have_link('Remover Receita')
    end

    scenario 'and remove favorite' do
      user = create(:user)
      another_user = create(:user, email: 'email12@email.com')

      recipe = create(:recipe, user: user)
      Favorite.create(user: another_user, recipe:recipe)

      sign_in user

      recipe.destroy

      sign_out user

      sign_in another_user

      visit root_path
      click_on 'Minhas Receitas Favoritas'

      expect(page).not_to have_link(recipe.title)
    end
  end
