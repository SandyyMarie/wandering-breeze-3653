require 'rails_helper'

RSpec.describe 'the contestants index page' do
    before :each do
        @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

        @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
        @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")

        @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    end

    it 'shows a list of names of all the contestants, along with a list of the projects theyve been on' do
        visit "/contestants"

        expect(page).to have_content(@kentaro.name)
        expect(page).to have_content(@upholstery_tux.name)
        expect(page).to have_content(@boardfit.name)

        expect(page).to have_content(@jay.name)
        expect(page).to have_content(@news_chic.name)
    end

end