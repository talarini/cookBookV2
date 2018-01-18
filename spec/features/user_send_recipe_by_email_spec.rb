require 'rails_helper'

  feature 'user send recipe by email to friend' do
    scenario 'succesfully' do
      user = create(:user)
      recipe = create(:recipe, title:'Sopa', user:user)

      visit root_path
      click_on recipe.title
      fill_in 'Email', with: 'email@email.com'
      fill_in 'Mensagem', with: 'Que delicia'

      expect(RecipesMailer).to receive(:share).with('email@email.com','Que delicia',recipe.id).and_call_original

      click_on 'Enviar'
      expect(page).to have_content('Receita compartilhada com email@email.com')
      expect(current_path).to eq recipe_path(recipe)
    end
  end
