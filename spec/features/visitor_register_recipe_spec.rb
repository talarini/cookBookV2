require 'rails_helper'

feature 'Visitor register recipe' do
  scenario 'successfully' do
    # cria os dados necessarios, nesse caso nao vamos criar dados no banco
    user = create(:user)
    sign_in user
    Cuisine.create(name: 'Arabe')
    RecipeType.create(name: 'Entrada')
    # simula a acao do usuario
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Titulo', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Facil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limao a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Facil')
    expect(page).to have_css('p', text: '45 minutos')
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limao a gosto.')
  end

  scenario 'and must fill in all fields' do
    # cria os dados necessarios, nesse caso nao vamos criar dados no banco
    user = create(:user)
    sign_in user

    Cuisine.create(name: 'Arabe')
    # simula a acao do usuario
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Titulo', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'must be signed in' do
    visit root_path

    expect(page).not_to have_link('Enviar uma receita')
  end
end
