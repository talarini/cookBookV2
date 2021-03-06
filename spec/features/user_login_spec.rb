require 'rails_helper'

feature 'User login' do
  scenario 'successfully' do
    user = create(:user)

    visit root_path
    click_on 'Entrar'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    within('div.actions') do
      click_on 'Entrar'
    end

    expect(page).to have_content("Bem Vindo #{user.email}")
  end
end
