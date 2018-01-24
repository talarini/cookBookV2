require 'rails_helper'

feature 'User update recipe' do
  scenario 'successfully' do
    # cria os dados necessarios
    user = create(:user)
    sign_in user

    arabian_cuisine = create(:cuisine)
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')

    appetizer_type = create(:recipe_type)
    main_type = create(:recipe_type, name: 'Prato Principal')
    dessert_type = create(:recipe_type, name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                           cuisine: arabian_cuisine, difficulty: 'Medio',
                           cook_time: 50,
                           ingredients: 'Farinha, acucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedacos pequenos, misture com o restante dos ingredientes',
                           user: user)

    # simula a acao do usuario
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Titulo', with: 'Bolo de cenoura'
    select 'Brasileira', from: 'Cozinha'
    select 'Sobremesa', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Medio'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
    fill_in 'Como Preparar', with: 'Faca um bolo e uma cobertura de chocolate'

    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Bolo de cenoura')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Sobremesa')
    expect(page).to have_css('p', text: 'Brasileira')
    expect(page).to have_css('p', text: 'Medio')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('p', text: 'Cenoura, farinha, ovo, oleo de soja e chocolate')
    expect(page).to have_css('p', text: 'Faca um bolo e uma cobertura de chocolate')
  end

  scenario 'and all fields must be filled' do
    # cria os dados necessarios, nesse caso nao vamos criar dados no banco
    # cria os dados necessarios
    user = create(:user)
    sign_in user

    arabian_cuisine = create(:cuisine)
    brazilian_cuisine = create(:cuisine, name: 'Brasileira')

    appetizer_type = create(:recipe_type)
    main_type = create(:recipe_type, name: 'Prato Principal')
    dessert_type = create(:recipe_type, name: 'Sobremesa')

    recipe = Recipe.create(title: 'Bolodecenoura', recipe_type: main_type,
                           cuisine: arabian_cuisine, difficulty: 'Medio',
                           cook_time: 50,
                           ingredients: 'Farinha, acucar, cenoura',
                           method: 'Cozinhe a cenoura, corte em pedacos pequenos, misture com o restante dos ingredientes',
                           user: user)
    # simula a acao do usuario
    visit root_path
    click_on 'Bolodecenoura'
    click_on 'Editar'

    fill_in 'Titulo', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''

    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end
end
