require 'rails_helper'
  feature 'user favorite recipe'do
    scenario 'successfully' do

      user = create(:user)
      another_user = create(:user, email:'anotheremail@email.com')
      cuisine = create(:cuisine, name:'Italiana')
      recipe_type = create(:recipe_type, name:'Tailandesa')

      recipe = create(:recipe, user:user)
      another_recipe = create(:recipe, title:'sopa', user:user, cuisine:cuisine, recipe_type:recipe_type)

      visit root_path
      sign_in another_user

      click_on recipe.title
      click_on 'Adicionar aos favoritos'
      click_on 'Minhas Receitas Favoritas'

      expect(page).to have_link(recipe.title)
      expect(page).not_to have_link(another_recipe.title)

    end

    scenario 'already favorited' do
      user = create(:user)
      another_user = create(:user, email:'123@email.com')
      recipe = create(:recipe, user:user)
      Favorite.create(user: user, recipe: recipe)

      visit root_path
      sign_in another_user

      click_on recipe.title
      click_on 'Adicionar aos favoritos'

      expect(page).not_to have_link('Adicionar aos favoritos')
      expect(page).to have_link('Remover dos favoritos')
    end
  end
