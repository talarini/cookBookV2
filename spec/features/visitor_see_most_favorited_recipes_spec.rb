# require 'rails_helper'
#
#   feature 'Visitor see most favorited recipes' do
#     scenario 'succesfully' do
#       user = create(:user, email:'email1@email.com')
#       user2 = create(:user, email:'email2@email.com')
#       user3 = create(:user, email:'email3@email.com')
#       user4 = create(:user, email:'email4@email.com')
#
#       cuisine = create(:cuisine, name:'cuisine')
#       cuisine2 = create(:cuisine, name:'cuisine2')
#       cuisine3 = create(:cuisine, name:'cuisine3')
#       cuisine4 = create(:cuisine, name:'cuisine4')
#
#       recipe_type = create(:recipe_type, name:'recipe_type')
#       recipe_type2 = create(:recipe_type, name:'recipe_type2')
#       recipe_type3 = create(:recipe_type, name:'recipe_type3')
#       recipe_type4 = create(:recipe_type, name:'recipe_type4')
#
#
#       recipe_list = create_list(:recipe, 10, title:'Sopa', user:user, cuisine: cuisine, recipe_type:recipe_type)
#       recipe = create(:recipe, user:user, cuisine: cuisine, recipe_type:recipe_type)
#       recipe2 = create(:recipe, user:user,cuisine: cuisine2, recipe_type:recipe_type2)
#       recipe3 = create(:recipe, user:user,cuisine: cuisine3, recipe_type:recipe_type3)
#       recipe4 = create(:recipe, user:user,cuisine: cuisine4, recipe_type:recipe_type4)
#
#       Favorite.create(user:user, recipe:recipe)
#       Favorite.create(user:user2, recipe:recipe)
#       Favorite.create(user:user3, recipe:recipe)
#       Favorite.create(user:user, recipe:recipe2)
#       Favorite.create(user:user2, recipe:recipe2)
#       Favorite.create(user:user3, recipe:recipe2)
#       Favorite.create(user:user, recipe:recipe3)
#       Favorite.create(user:user2, recipe:recipe3)
#       Favorite.create(user:user3, recipe:recipe3)
#       Favorite.create(user:user, recipe:recipe4)
#
#       visit root_path
#
#       expect(page).to have_content('Receitas mais favoritadas')
#       #expect(find("//div[text()='favorited']/..")).to have_link(recipe2.title)
#       # expect(page).to have_link(recipe2.title)
#       expect(page).to have_link(recipe3.title)
#       expect(page).to have_link(recipe4.title)
#       expect(page).not_to have_link(recipe.title)
#       expect(page).not_to have_link(recipe_list.title)
#
#     end
#   end
