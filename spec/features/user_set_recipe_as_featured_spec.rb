require 'rails_helper'

  feature 'User ser recipe as featured'do
    scenario 'succesfully' do
      user = create(:user)
      recipe = create(:recipe, title:'Canja', user:user)

      sign_in user
      visit root_path

      click_on 'Enviar uma receita'

      fill_in 'Título', with: 'Tabule'
      select 'Arabe', from: 'Cozinha'
      select 'Entrada', from: 'Tipo da Receita'
      fill_in 'Dificuldade', with: 'Fácil'
      fill_in 'Tempo de Preparo', with: '45'
      fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
      fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
      page.check 'Destaque'

      click_on 'Enviar'

      expect(page).to have_css('figure.featured')
    end
    scenario 'featured recipe in root' do
      user = create(:user)
      recipe = create(:recipe, user:user, featured:true)

      visit root_path

      expect(page).to have_css('figure.featured')
    end
    scenario 'featured recipe in listing recipe page' do
      user = create(:user)
      recipe = create(:recipe, user:user, featured:true)

      visit root_path
      click_on 'Visualizar todas receitas'

      expect(page).to have_css('figure.featured')
    end

  end
