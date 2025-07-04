class GoodMemoriesController < ApplicationController
  before_action :set_good_memory, only: [:show, :edit, :update, :destroy]

  def index
    @good_memories = GoodMemory.recent.limit(10)
    @total_count = GoodMemory.count
    @this_month_count = GoodMemory.this_month.count
  end

  def show
  end

  def new
    @good_memory = GoodMemory.new(date: Date.current)
  end

  def create
    @good_memory = GoodMemory.new(good_memory_params)
    
    if @good_memory.save
      redirect_to @good_memory, notice: '今日の良かったことを記録しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @good_memory.update(good_memory_params)
      redirect_to @good_memory, notice: '思い出を更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @good_memory.destroy
    redirect_to good_memories_url, notice: '思い出を削除しました。'
  end

  def monthly
    @year = params[:year].to_i
    @month = params[:month].to_i
    @good_memories = GoodMemory.by_month(@year, @month).recent
    @month_name = Date.new(@year, @month, 1).strftime("%Y年%m月")
  end

  private

  def set_good_memory
    @good_memory = GoodMemory.find(params[:id])
  end

  def good_memory_params
    params.require(:good_memory).permit(:content, :date, :mood)
  end
end
