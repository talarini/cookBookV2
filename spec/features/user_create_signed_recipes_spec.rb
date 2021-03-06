require 'rails_helper'

feature 'logged user create recipe' do
  scenario 'successfully' do
    #
    # user = User.create(email:'aaa@email.com', password:'123456')
    # cuisine = Cuisine.create(name: 'Arabe')
    # recType = RecipeType.create(name: 'Entrada')

    user = create(:user)
    cuisine = create(:cuisine)
    recType = create(:recipe_type)

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content("Bem Vindo #{user.email}")

    click_on 'Enviar uma receita'

    fill_in 'Titulo', with: 'Tabule'
    select 'Arabe', from: 'Cozinha'
    select 'Entrada', from: 'Tipo da Receita'
    fill_in 'Dificuldade', with: 'Facil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola,
                                   tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir.
                                   Adicione limao a gosto.'
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

    expect(page).to have_content("Enviado por #{user.email}")
  end
end
