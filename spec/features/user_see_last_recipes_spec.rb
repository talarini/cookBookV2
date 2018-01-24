require 'rails_helper'

feature 'user see last recipes on root' do
  scenario 'successfully' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'contemporanea')
    recipe_type = create(:recipe_type, name: 'petisco')

    recipe = create(:recipe, title: 'sopa', user: user)
    recipe_list = create_list(:recipe, 8, cuisine: cuisine,
                                          recipe_type: recipe_type, user: user)

    sign_in user
    visit root_path

    expect(page).not_to have_link(recipe.title)
    expect(page).to have_css('div.recipes', count: 6)
  end

  scenario 'and can see link to all recipes' do
    user = create(:user)
    cuisine = create(:cuisine, name: 'contemporanea')
    recipe_type = create(:recipe_type, name: 'petisco')

    recipe_list = create_list(:recipe, 8, cuisine: cuisine,
                                          recipe_type: recipe_type, user: user)

    visit root_path

    click_on 'Visualizar todas receitas'

    expect(page).to have_css('div.recipes', count: 8)
  end
end
