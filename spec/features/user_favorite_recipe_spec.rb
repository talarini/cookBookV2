require 'rails_helper'

feature 'user favorite recipe' do
  scenario 'successfully' do
    user = create(:user)
    another_user = create(:user, email: 'anotheremail@email.com')
    cuisine = create(:cuisine, name: 'Portuguesa')
    recipe_type = create(:recipe_type, name: 'petisco')

    recipe = create(:recipe, user: user)
    another_recipe = create(:recipe, title: 'sopa', user: user,
                                     cuisine: cuisine, recipe_type: recipe_type)

    visit root_path
    sign_in another_user

    within('div.last_recipes') do
      click_on recipe.title
    end

    click_on 'Adicionar aos favoritos'
    click_on 'Minhas Receitas Favoritas'

    expect(page).to have_link(recipe.title)
    expect(page).not_to have_link(another_recipe.title)
  end
  scenario 'already favorited' do
    user = create(:user)
    another_user = create(:user, email: 'anotheremail@email.com')
    recipe = create(:recipe, user: user)
    Favorite.create(user: user, recipe: recipe)

    visit root_path
    sign_in another_user

    within('div.last_recipes') do
      click_on recipe.title
    end

    click_on 'Adicionar aos favoritos'

    expect(page).not_to have_link('Adicionar aos favoritos')
    expect(page).to have_link('Remover dos favoritos')
  end
  scenario 'user unfavorite recipe' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    Favorite.create(user: user, recipe: recipe)

    sign_in user

    visit root_path

    within('div.last_recipes') do
      click_on recipe.title
    end

    click_on 'Remover dos favoritos'

    expect(page).to have_content('Receita removida dos favoritos')

    expect(page).not_to have_link('Remover dos favoritos')
    expect(page).to have_link('Adicionar aos favoritos')
  end
  scenario 'another user favorite recipe' do
    user = create(:user)
    another_user = create(:user, email: 'anotheremail@email.com')
    recipe = create(:recipe, user: user)
    Favorite.create(user: user, recipe: recipe)

    sign_in another_user
    visit root_path

    within('div.last_recipes') do
      click_on recipe.title
    end

    expect(page).to have_link('Adicionar aos favoritos')
    expect(page).not_to have_link('Remover dos favoritos')
  end
  scenario 'user favorites more than one recipe' do
    user = create(:user)
    recipe = create(:recipe, user: user)
    cuisine = create(:cuisine, name: 'contemporanea')
    recipe_type = create(:recipe_type, name: 'petisco')
    another_recipe = create(:recipe, title: 'sopa', cuisine: cuisine,
                                     recipe_type: recipe_type, user: user)
    Favorite.create(user: user, recipe: recipe)

    sign_in user
    visit root_path

    within('div.last_recipes') do
      click_on another_recipe.title
    end

    expect(page).to have_link('Adicionar aos favoritos')
    expect(page).not_to have_link('Remover dos favoritos')
  end
end
