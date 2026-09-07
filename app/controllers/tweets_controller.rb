class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

  def index
    # 一覧画面用のツイート全件取得
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def show
    # @tweet が存在しない場合は一覧画面にリダイレクト
    if @tweet.nil?
      redirect_to tweets_path, alert: '指定されたレコードが見つかりませんでした。'
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path, notice: '新しい蔵書録を登録しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: '蔵書録を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: '蔵書録を削除しました。'
  end

  private

  def set_tweet
    # find_by(id: ...) を使うことで、IDが存在しない場合でも例外を出さずに nil をセットします
    @tweet = Tweet.find_by(id: params[:id])
  end

  def tweet_params
    # アプリで使用しているカラム名に合わせて必要に応じて調整してください
    params.require(:tweet).permit(:name, :photo, :image, :text)
  end
end