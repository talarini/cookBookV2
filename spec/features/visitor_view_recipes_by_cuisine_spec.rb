require 'rails_helper'

feature 'Visitor view recipes by cuisine' do
  scenario 'from home page' do
    # cria os dados necessarios previamente
    user = create :user
    sign_in user

    cuisine = create(:cuisine, name: 'Brasileira')
    recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura', recipe_type: recipe_type,
                             cuisine: cuisine, user: user)

    # simula a acao do usuario
    visit root_path
    click_on cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: cuisine.name)
    expect(page).to have_css('h1', text: recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view only cuisine recipes' do
    # cria os dados necessarios previamente
    user = create :user
    sign_in user
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura',
                             recipe_type: dessert_recipe_type, cuisine: brazilian_cuisine,
                             user: user)

    italian_cuisine = create(:cuisine, name: 'Italiana')
    main_recipe_type = create(:recipe_type, name: 'Prato Principal')
    italian_recipe = create(:recipe, title: 'Macarrao Carbonara',
                                     recipe_type: main_recipe_type,
                                     cuisine: italian_cuisine, user: user)
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).to have_css('h1', text: italian_recipe.title)
    expect(page).to have_css('li', text: italian_recipe.recipe_type.name)
    expect(page).to have_css('li', text: italian_recipe.cuisine.name)
    expect(page).to have_css('li', text: italian_recipe.difficulty)
    expect(page).to have_css('li', text: "#{italian_recipe.cook_time} minutos")
  end

  scenario 'and cuisine has no recipe' do
    # cria os dados necessarios previamente
    user = create :user
    sign_in user

    brazilian_cuisine = create(:cuisine, name: 'Brasileira')
    dessert_recipe_type = create(:recipe_type, name: 'Sobremesa')
    recipe = create(:recipe, title: 'Bolo de cenoura',
                             recipe_type: dessert_recipe_type,
                             cuisine: brazilian_cuisine, user: user)

    italian_cuisine = create(:cuisine, name: 'Italiana')
    # simula a acao do usuario
    visit root_path
    click_on italian_cuisine.name

    # expectativas do usuario apos a acao
    expect(page).not_to have_content(recipe.title)
    expect(page).to have_content('Nenhuma receita encontrada para este tipo de cozinha')
  end
end
