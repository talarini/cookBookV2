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

    scenario 'mail with correct data' do
      user = create(:user)
      recipe = create(:recipe, title:'Sopa', user:user)

      visit root_path
      click_on recipe.title
      fill_in 'Email', with: 'teste@teste.com'
      fill_in 'Mensagem', with: 'Que delicia'
      click_on 'Enviar'

      expect(page).to have_content('Receita compartilhada com teste@teste.com')
      expect(current_path).to eq recipe_path(recipe)

      email = ActionMailer::Base.deliveries.last
      expect(email.to).to include 'teste@teste.com'
      expect(email.subject).to eq 'Um amigo lhe enviou uma receita do CookBook'
      expect(email.from).to include 'no-reply@teste.com'
      expect(email.body).to include 'Que delicia'
      expect(email.body).to include recipe_url(recipe, host:'localhost:3000')
    end
  end
