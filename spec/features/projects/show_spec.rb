require 'rails_helper'

RSpec.describe 'when visiting the projects show page' do
    before :each do
        @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

        @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")
        @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")

        @kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        
        
        ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
        ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    end

    it 'shows the projects name and material, along with the challenge theme on the projects#show page' do
        visit "/projects/#{@lit_fit.id}"

        expect(page).to have_content(@lit_fit.name)
        expect(page).to have_content(@lit_fit.material)
        expect(page).to have_content(@furniture_challenge.theme)
    end

    it 'shows the count of the number of contestants on that project' do
        visit "/projects/#{@news_chic.id}" 

        expect(page).to have_content(@news_chic.name)
        expect(page).to have_content(@news_chic.material)
        expect(page).to have_content(@recycled_material_challenge.theme)
        expect(page).to have_content("Number of Contestants: 2")
    end

    it 'can show the average years of experience for the contestants that worked on that project' do
        visit "/projects/#{@upholstery_tux.id}" 

        expect(page).to have_content(@upholstery_tux.name)
        expect(page).to have_content(@upholstery_tux.material)
        expect(page).to have_content(@furniture_challenge.theme)
        expect(page).to have_content("Number of Contestants: 2")
        expect(page).to have_content("Average Contestant Experience: 10 years")
        save_and_open_page
    end
end