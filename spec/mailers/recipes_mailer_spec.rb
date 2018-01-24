require 'rails_helper'

RSpec.describe RecipesMailer do
  describe 'share' do
    it 'send email' do
      user = create(:user)
      recipe = create(:recipe, user: user)

      email = RecipesMailer.share('teste@teste.com', 'corpo', recipe.id)

      expect(email.to).to include 'teste@teste.com'
      expect(email.subject).to eq 'Um amigo lhe enviou uma receita do CookBook'
      expect(email.from).to include 'no-reply@teste.com'
      expect(email.body).to include 'corpo'
      expect(email.body).to include recipe_url(recipe)
    end
  end
end
