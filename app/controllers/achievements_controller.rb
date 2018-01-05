class AchievementsController < ApplicationController
  def index
    @achievements = Achievement.public_access
  end

  def new
    @achievement = Achievement.new
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_path(@achievement)
    end
  end

  def create
    achievement = Achievement.new(achievement_params)
    if achievement.save
      redirect_to achievement_path(achievement.id), notice: 'Achievement has been created'
    else
      redirect_to new_achievement_path, notice: "can't be blank"
    end
  end

  def destroy
    achievement = Achievement.find(params[:id])
    redirect_to achievements_path if achievement.destroy
  end

  private

  def achievement_params
    params.require(:achievement).permit(:title,
                                        :tescription,
                                        :privacy,
                                        :featured,
                                        :cover_image)
  end
end
