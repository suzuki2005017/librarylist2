class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    # 常に新しい投稿が先頭（配列の0番目）に来るようにする
    @tweets = Tweet.order(created_at: :desc)
  end

  def show
    @comments = @tweet.comments.includes(:user)
  end

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: '投稿しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to tweets_path, alert: '権限がありません' unless owner?
  end

  def update
    if owner? && @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: '更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if owner?
      @tweet.destroy
      redirect_to tweets_path, notice: '削除しました'
    else
      redirect_to tweets_path, alert: '権限がありません'
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params:[:id]) rescue Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:name, :place, :time, :net, :outlet, :recommend, :image, :photo)
  end

  def owner?
    user_signed_in? && @tweet.user_id == current_user.id
  end
end