class AchievementsController < ApplicationController
  def new
    @achievement = Achievement.new
  end

  def show
    @achievement = Achievement.find(params[:id])
    @tescription = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@achievement.tescription)
  end

  def create
    achievement = Achievement.new(achievement_params)
    if achievement.save
      redirect_to root_url, notice: 'Achievement has been created'
    else
      redirect_to new_achievement_path, notice: "can't be blank"
    end
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