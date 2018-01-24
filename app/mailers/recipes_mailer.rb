class RecipesMailer < ApplicationMailer
  default from: 'no-reply@teste.com'

  def share(email, message, recipe_id)
    @message = message
    @recipe = Recipe.find(recipe_id)
    mail(to: email, subject: 'Um amigo lhe enviou uma receita do CookBook')
  end
end
