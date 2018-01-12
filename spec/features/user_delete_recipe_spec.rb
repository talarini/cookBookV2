require 'rails_helper'

feature  'User delete recipe' do
  scenario 'successfully' do
    arabian_cuisine = Cuisine.create(name: 'Arabe')
    appetizer_type = RecipeType.create(name: 'Entrada')
    user = create (:user)

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: appetizer_type,
      cuisine: arabian_cuisine, difficulty: 'Médio',
      cook_time: 50,
      ingredients: 'Farinha, açucar, cenoura',
      method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
      user: user)

      visit root_path
      click_on recipe.title
      click_on 'Remover Receita'

      expect(page).to have_current_path(root_path)
      expect(page).not_to have_content(recipe.title)
    end
  end
