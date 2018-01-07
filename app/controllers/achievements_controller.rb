class AchievementsController < ApplicationController
  before_action :authenticate_user!,
                only: %i[new
                         create
                         edit
                         update
                         destroy]
  before_action :owners_only,
                only: %i[edit
                         update
                         destroy]

  def index
    @achievements = Achievement.get_public_achievements
  end

  def new
    @achievement = Achievement.new
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def edit; end

  def update
    redirect_to achievement_path(@achievement) if
    @achievement
    .update_attributes(achievement_params)
  end

  def create
    # Can't just call new method normally cuz this is Rspec mock,
    # I need to allow the CreateAchievement class
    # to receive the new method.
    service = CreateAchievement.new(achievement_params.to_h, current_user)
    service.create
    if service.create?
      redirect_to achievement_path(service.achievement)
    else
      @achievement = service.achievement
      render :new
    end
  end

  def destroy
    redirect_to achievements_path if @achievement.destroy
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title,
                                        :tescription,
                                        :privacy,
                                        :featured,
                                        :cover_image)
  end

  def owners_only
    @achievement = Achievement.find(params[:id])
    redirect_to achievements_path if current_user != @achievement.user
  end
end
