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
    @achievements = Achievement.public_access
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
    achievement = Achievement.new(achievement_params
    .merge(user: current_user))
    if achievement.save
      redirect_to achievement_path(achievement.id),
                  notice: 'Achievement has been created'
    else
      redirect_to new_achievement_path, notice: achievement.errors.to_s
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
