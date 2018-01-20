require 'rails_helper'

  feature 'Visitor see most favorited recipes' do
    scenario 'succesfully' do
      user = create(:user, email:'email1@email.com')
      user2 = create(:user, email:'email2@email.com')
      user3 = create(:user, email:'email3@email.com')

      cuisine = create(:cuisine, name:'cuisine')
      cuisine2 = create(:cuisine, name:'cuisine2')
      cuisine3 = create(:cuisine, name:'cuisine3')
      cuisine4 = create(:cuisine, name:'cuisine4')
      cuisine5 = create(:cuisine, name:'cuisine5')

      recipe_type = create(:recipe_type, name:'recipe_type')
      recipe_type2 = create(:recipe_type, name:'recipe_type2')
      recipe_type3 = create(:recipe_type, name:'recipe_type3')
      recipe_type4 = create(:recipe_type, name:'recipe_type4')
      recipe_type5 = create(:recipe_type, name:'recipe_type5')

      recipe = create(:recipe, title:'receita1',user:user, cuisine: cuisine, recipe_type:recipe_type)
      recipe2 = create(:recipe, title:'receita2',user:user,cuisine: cuisine2, recipe_type:recipe_type2)
      recipe3 = create(:recipe, title:'receita3',user:user,cuisine: cuisine3, recipe_type:recipe_type3)
      recipe4 = create(:recipe, title:'receita4', user:user,cuisine: cuisine4, recipe_type:recipe_type4)
      recipe5 = create(:recipe, title:'receita5', user:user,cuisine: cuisine5, recipe_type:recipe_type5)

      #1 time
      Favorite.create(user:user, recipe:recipe4)
      Favorite.create(user:user, recipe:recipe)
      #3times
      Favorite.create(user:user, recipe:recipe2)
      Favorite.create(user:user2, recipe:recipe2)
      Favorite.create(user:user3, recipe:recipe2)
      Favorite.create(user:user, recipe:recipe3)
      Favorite.create(user:user2, recipe:recipe3)
      Favorite.create(user:user3, recipe:recipe3)
      Favorite.create(user:user, recipe:recipe5)
      Favorite.create(user:user2, recipe:recipe5)
      Favorite.create(user:user3, recipe:recipe5)

      visit root_path

      expect(page).to have_content('Receitas mais favoritadas')
      
      expect(page).to have_css('div.favorited_recipes',text: recipe2.title)
      expect(page).to have_css('div.favorited_recipes',text: recipe3.title)
      expect(page).to have_css('div.favorited_recipes',text: recipe5.title)
      expect(page).not_to have_css('div.favorited_recipes',text: recipe.title)
      expect(page).not_to have_css('div.favorited_recipes',text: recipe4.title)

    end
  end
