require 'rails_helper'

describe AchievementsController do
  describe 'DELETE destroy' do
    let(:achievement) { FactoryBot.create(:public_achievement) }
    it 'redirects to achievement#index' do
      delete :destroy, params: { id: achievement.id }
      expect(response).to redirect_to(achievements_path)
    end
    it 'deletes achievement in the database' do
      delete :destroy, params: { id: achievement.id }
      expect(Achievement.exists?(achievement.id)).to be_falsy
    end
  end

  describe 'PUT update' do
    let(:achievement) { FactoryBot.create(:public_achievement) }
    context 'valid data' do
      let(:valid_data) { FactoryBot.attributes_for(:public_achievement, title: 'I am the toughest and smartest warrior') }

      it 'redirects to achievemets#show' do
        # params value will be used in the controller during test case. Try to comment it and read the error to understand it
        put :update, params: { id: achievement, achievement: valid_data }
        expect(response).to redirect_to achievement_path(achievement)
      end

      it 'updates achievement in the database' do
        put :update, params: { id: achievement, achievement: valid_data }
        # re_fetch the data after updating
        achievement.reload
        expect(achievement.title).to eq('I am the toughest and smartest warrior')
      end
    end

    context 'invalid data' do
      let(:valid_data) { FactoryBot.attributes_for(:public_achievement, title: '', tescription: 'I am the king of NAVY SEALS') }
    end
  end

  describe 'GET index' do
    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns only public achievements to template' do
      public_achievement = FactoryBot.create(:public_achievement)
      private_achievement = FactoryBot.create(:private_achievement)
      get :index
      expect(assigns(:achievements)).to match_array([public_achievement])
    end
  end

  describe 'GET edit' do
    let(:achievement) { FactoryBot.create(:public_achievement) }
    it 'renders :edit template' do
      get :edit, params: { id: achievement }
      expect(response).to render_template(:edit)
    end

    it 'assigns the requested achievement to template' do
      get :edit, params: { id: achievement }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe 'GET new' do
    it 'renders :new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns new Achievement to @achievement' do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  describe 'GET show' do
    let(:achievement) { FactoryBot.create(:public_achievement) }

    it 'renders :show template' do
      get :show, params: { id: achievement.id }
      expect(response).to render_template(:show)
    end

    it 'assigns requested achievement to @achievement' do
      get :show, params: { id: achievement.id }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  describe 'POST create' do
    context 'valid data' do
      let(:valid_data) { FactoryBot.attributes_for(:public_achievement) }
      it 'redirects to achievements#show' do
        post :create, params: { achievement: valid_data }
        # puts "Achievement is: #{achievement_test}"
        expect(response).to redirect_to(Achievement.last)
      end

      it 'create new achievement in database' do
        # Comparing the Achivement before and after (the one in the block) by one
        expect do
          post :create, params: { achievement: valid_data }
        end.to change(Achievement, :count).by(1)
      end
    end
  end

  context 'invalid data' do
    # usually when we have context, we'll have some data. Therefore, prepare them in advance
    let(:invalida_data) { FactoryBot.attributes_for(:public_achievement, title: '') }
    it 'renders :new template' do
      post :create, params: { achievement: invalida_data }
      expect(response).to redirect_to('http://test.host/achievements/new')
    end

    it 'does not create new achievement in the database' do
      expect do
        post :create, params: { achievement: invalida_data }
      end.not_to change(Achievement, :count)
    end
  end
end
