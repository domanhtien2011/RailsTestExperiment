require 'rails_helper'

describe AchievementsController do
  # shared_examples 'public access to achievements' do
  #   let(:guest_user) { FactoryBot.create(:user) }
  #   describe 'GET index' do
  #     it 'renders :index template' do
  #       get :index
  #       expect(response).to render_template(:index)
  #     end
  #   end

  #   describe 'GET show' do
  #     let(:achievement) { FactoryBot.create(:public_achievement, user: guest_user) }

  #     it 'renders :show template' do
  #       get :show, params: { id: achievement.id }
  #       expect(response).to render_template(:show)
  #     end

  #     it 'assigns requested achievement to @achievement' do
  #       get :show, params: { id: achievement.id }
  #       expect(assigns(:achievement)).to eq(achievement)
  #     end
  #   end
  # end

  # describe 'guest user' do
  #   it_behaves_like 'public access to achievements'
  #   let(:guest_user) { FactoryBot.create(:user) }
  #   describe 'GET new' do
  #     it 'redirects new user to login page' do
  #       get :new
  #       # the below route is provided by devise gem which is already included in the rails_helper.rb file
  #       expect(response).to redirect_to 'http://test.host/users/sign_in'
  #     end
  #   end

  #   describe 'POST create' do
  #     it 'redirects to login page' do
  #       post :create, params: { achievement: FactoryBot.attributes_for(:public_achievement), user: guest_user }
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end

  #   describe 'GET edit' do
  #     let(:achievement) { FactoryBot.create(:public_achievement, user: guest_user) }
  #     it 'redirects to login page' do
  #       get :edit, params: { id: achievement }
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end

  #   describe 'PUT update' do
  #     it 'redirects to login page' do
  #       put :update, params: { id: FactoryBot.create(:public_achievement, user: guest_user), achievement: FactoryBot.attributes_for(:public_achievement) }
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end

  #   describe 'DELETE destroy' do
  #     let(:achievement) { FactoryBot.create(:public_achievement, user: guest_user) }
  #     it 'redirects to login page' do
  #       delete :destroy, params: { id: achievement.id }
  #       expect(response).to redirect_to new_user_session_path
  #     end
  #   end
  # end

  # describe 'authenticated user' do
  #   let(:user) { FactoryBot.create(:user) }
  #   before do
  #     # The method below is a devise's helper
  #     sign_in(user)
  #   end

  #   describe 'GET index' do
  #     it 'renders :index template' do
  #       get :index
  #       expect(response).to render_template(:index)
  #     end

  #     # it 'assigns only public achievements to template' do
  #     #   public_achievement  = FactoryBot.create(:public_achievement)
  #     #   private_achievement = FactoryBot.create(:private_achievement)
  #     #   get :index
  #     #   expect(assigns(:achievements).size).to eq(1)
  #     # end
  #   end

  #   describe 'GET show' do
  #     let(:achievement) { FactoryBot.create(:public_achievement, user: user) }

  #     it 'renders :show template' do
  #       get :show, params: { id: achievement.id }
  #       expect(response).to render_template(:show)
  #     end

  #     it 'assigns requested achievement to @achievement' do
  #       get :show, params: { id: achievement.id }
  #       expect(assigns(:achievement)).to eq(achievement)
  #     end
  #   end

  #   describe 'GET new' do
  #     it 'renders :new template' do
  #       get :new
  #       expect(response).to render_template(:new)
  #     end
  #     it 'assigns new Achievement to @achievement' do
  #       get :new
  #       expect(assigns(:achievement)).to be_a_new(Achievement)
  #     end
  #   end

  #   describe 'POST create' do
  #     context 'valid data' do
  #       let(:valid_data) do
  #         FactoryBot.attributes_for(
  #           :achievement, user_id: user.id, privacy: 'public_access'
  #         )
  #       end
  #       it 'redirects to achievements#show' do
  #         puts "valid data: #{valid_data}"
  #         post :create, params: { achievement: valid_data }
  #         # puts "Achievement is: #{achievement_test}"
  #         expect(response).to redirect_to(Achievement.last)
  #       end

  #       it 'create new achievement in database' do
  #         # Comparing the Achivement before and after (the one in the block) by one
  #         expect do
  #           post :create, params: { achievement: valid_data }
  #         end.to change(Achievement, :count).by(1)
  #       end
  #     end
  #   end

  #   context 'invalid data' do
  #     # usually when we have context, we'll have some data. Therefore, prepare them in advance
  #     let(:invalida_data) { FactoryBot.attributes_for(:public_achievement, title: '') }
  #     it 'renders :new template' do
  #       post :create, params: { achievement: invalida_data }
  #       expect(response).to redirect_to('http://test.host/achievements/new')
  #     end

  #     it 'does not create new achievement in the database' do
  #       expect do
  #         post :create, params: { achievement: invalida_data }
  #       end.not_to change(Achievement, :count)
  #     end
  #   end

  #   context 'is not the owner of the achievement' do
  #     let(:sample_user) { FactoryBot.create(:user) }
  #     describe 'GET edit' do
  #       let(:achievement) { FactoryBot.create(:public_achievement, user: sample_user) }
  #       it 'redirects to achievements page' do
  #         get :edit, params: { id: achievement }
  #         expect(response).to redirect_to achievements_path
  #       end
  #     end

  #     describe 'PUT update' do
  #       it 'redirects to achievements page' do
  #         put :update, params: { id: FactoryBot.create(:public_achievement, user: sample_user), achievement: FactoryBot.attributes_for(:public_achievement) }
  #         expect(response).to redirect_to achievements_path
  #       end
  #     end

  #     describe 'DELETE destroy' do
  #       let(:achievement) { FactoryBot.create(:public_achievement, user: sample_user) }
  #       it 'redirects to achievements page' do
  #         delete :destroy, params: { id: achievement.id }
  #         expect(response).to redirect_to achievements_path
  #       end
  #     end
  #   end

  #   context 'is the owner of the achievement' do
  #     let(:achievement) { FactoryBot.create(:public_achievement, user: user) }
  #     describe 'DELETE destroy' do
  #       it 'redirects to achievement#index' do
  #         delete :destroy, params: { id: achievement.id }
  #         expect(response).to redirect_to(achievements_path)
  #       end
  #       it 'deletes achievement in the database' do
  #         delete :destroy, params: { id: achievement.id }
  #         expect(Achievement.exists?(achievement.id)).to be_falsy
  #       end
  #     end

  #     describe 'PUT update' do
  #       context 'valid data' do
  #         let(:valid_data) { FactoryBot.attributes_for(:public_achievement, title: 'I am the toughest and smartest warrior', user: user) }

  #         it 'redirects to achievemets#show' do
  #           # params value will be used in the controller during test case. Try to comment it and read the error to understand it
  #           put :update, params: { id: achievement, achievement: valid_data }
  #           expect(response).to redirect_to achievement_path(achievement)
  #         end

  #         it 'updates achievement in the database' do
  #           put :update, params: { id: achievement, achievement: valid_data }
  #           # re_fetch the data after updating
  #           achievement.reload
  #           expect(achievement.title).to eq('I am the toughest and smartest warrior')
  #         end
  #       end

  #       context 'invalid data' do
  #         let(:valid_data) { FactoryBot.attributes_for(:public_achievement, title: '', tescription: 'I am the king of NAVY SEALS') }
  #       end
  #     end

  #     describe 'GET edit' do
  #       it 'renders :edit template' do
  #         get :edit, params: { id: achievement }
  #         expect(response).to render_template(:edit)
  #       end

  #       it 'assigns the requested achievement to template' do
  #         get :edit, params: { id: achievement }
  #         expect(assigns(:achievement)).to eq(achievement)
  #       end
  #     end
  #   end
  # end

  # Controller Isolation Test starts from here
  describe 'guest user' do
    describe 'GET index' do
      let(:achievement) { instance_double(Achievement) }

      before do
        allow(Achievement).to receive(
          :get_public_achievements
        ) { [achievement] }
      end

      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns public achievement' do
        get :index
        expect(assigns(:achievements)).to eq([achievement])
      end
    end
  end

  describe 'authenticated user' do
    let(:user) { instance_double(User) }
    before do
      allow(controller).to receive(:authenticate_user!) { true }
      allow(controller).to receive(:current_user) { user }
    end

    describe 'POST create' do
      let(:achievement_params) { { title: 'I am the king of my fate' } }
      let(:create_achievement) { instance_double(CreateAchievement) }
      before do
        allow(CreateAchievement).to receive(:new) { create_achievement }
      end

      it 'sends create message to CreateAchievement' do
        expect(CreateAchievement).to receive(:new)
        expect(create_achievement).to receive(:create)
        post :create, params: { achievement: achievement_params }
      end
    end
  end
end
