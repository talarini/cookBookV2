require 'rails_helper'

feature 'Visitor cannot edit other recipe' do
    scenario 'sucessfully' do
      user = create (:user)
      new_user = create(:user, email:'email3@email.com')
      
      sign_in user

      cuisine = create(:cuisine, name: 'Brasileira')
      recipe_type = create(:recipe_type, name: 'Sobremesa')

      recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user:new_user)

      visit root_path
      click_on recipe.title

      expect(page).not_to have_link("Editar")
    end
    scenario 'recipe owner edit his recipe' do
      user = create (:user)
      sign_in user

      cuisine = create(:cuisine, name: 'Brasileira')
      recipe_type = create(:recipe_type, name: 'Sobremesa')

      recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user:user)

      visit root_path
      click_on recipe.title

      expect(page).to have_link("Editar")
    end
end
