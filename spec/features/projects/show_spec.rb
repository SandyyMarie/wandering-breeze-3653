require 'rails_helper'

RSpec.describe 'the projects show page' do
    before :each do
        @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)
        @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    end


# As a visitor,
# When I visit a project's show page ("/projects/:id"),
# I see that project's name and material
# And I also see the theme of the challenge that this project belongs to.
# (e.g.    Litfit
#     Material: Lamp Shade
#   Challenge Theme: Apartment Furnishings)
    it 'shows the projects name and material, along with the challenge theme on the projects#show page' do
        visit "/projects/#{@lit_fit.id}" #might need to revisit which id 

        expect(page).to have_content(@lit_fit.name)
        expect(page).to have_content(@lit_fit.material)
        expect(page).to have_content(@furniture_challenge.theme)
    end
end