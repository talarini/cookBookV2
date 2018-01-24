require 'rails_helper'

feature 'Visitor must login to edit recipe' do
  scenario 'sucessfully' do
    user = create :user
    sign_in user

    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    visit root_path
    click_on recipe.title

    expect(page).to have_link('Editar')
  end

  scenario 'user not logged' do
    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')

    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine)

    visit root_path
    click_on recipe.title

    expect(page).not_to have_link('Editar')
  end
end
