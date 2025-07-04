class GoodMemory < ApplicationRecord
  # enumで気分を定義
  enum mood: {
    very_bad: 1,
    bad: 2,
    normal: 3,
    good: 4,
    very_good: 5
  }

  # バリデーション
  validates :content, presence: true, length: { maximum: 1000 }
  validates :date, presence: true
  validates :mood, presence: true, inclusion: { in: moods.keys }

  # スコープ
  scope :recent, -> { order(date: :desc) }
  scope :by_month, ->(year, month) { where("EXTRACT(YEAR FROM date) = ? AND EXTRACT(MONTH FROM date) = ?", year, month) }
  scope :this_month, -> { where(date: Date.current.beginning_of_month..Date.current.end_of_month) }
  scope :last_month, -> { where(date: 1.month.ago.beginning_of_month..1.month.ago.end_of_month) }

  # 気分の日本語表示
  def mood_text
    case mood
    when 'very_bad'
      'とても悪い'
    when 'bad'
      '悪い'
    when 'normal'
      '普通'
    when 'good'
      '良い'
    when 'very_good'
      'とても良い'
    end
  end

  # 気分の絵文字
  def mood_emoji
    case mood
    when 'very_bad'
      '😢'
    when 'bad'
      '😔'
    when 'normal'
      '😐'
    when 'good'
      '😊'
    when 'very_good'
      '😄'
    end
  end
end
