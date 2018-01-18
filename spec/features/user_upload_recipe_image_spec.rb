require 'rails_helper'

feature 'user upload recipe image' do
  scenario 'succesfully' do
    user = create(:user)
    cuisine = create(:cuisine, name:'Arabe')
    recipe_type = create(:recipe_type, name:'Entrada')

    sign_in user

    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'

    page.attach_file('Foto do Prato', Rails.root + 'spec/support/bolo.jpeg')
    click_on 'Enviar'

    expect(page).to have_css("img[src*='bolo.jpeg']")
  end
end
