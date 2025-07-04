# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# サンプルデータを作成
puts "サンプルデータを作成中..."

# 過去30日分のサンプルデータを作成
30.times do |i|
  date = i.days.ago
  content = [
    "家族と笑顔で過ごせた一日でした。夕食の時間が特に楽しかったです。",
    "美味しいお茶を飲みながら、ゆっくりとした時間を過ごせました。",
    "友達から励ましのメッセージをもらって、心が温かくなりました。",
    "天気が良くて、散歩が気持ちよかったです。",
    "新しい本を読んで、新しい発見がありました。",
    "料理を作って、家族に喜んでもらえました。",
    "音楽を聴きながら、リラックスした時間を過ごせました。",
    "お気に入りのカフェで、美味しいケーキを食べました。",
    "友達と電話で話して、久しぶりに笑い合えました。",
    "朝の散歩で、きれいな花を見つけました。",
    "お気に入りのドラマを見て、感動しました。",
    "家族と一緒に映画を見て、楽しい時間を過ごしました。",
    "新しいレシピに挑戦して、美味しくできました。",
    "友達とランチをして、楽しい会話ができました。",
    "お気に入りの音楽を聴いて、心が癒されました。",
    "家族と一緒にゲームをして、笑い合えました。",
    "新しいお店を発見して、美味しい料理を食べました。",
    "友達から素敵なプレゼントをもらいました。",
    "家族と一緒に写真を撮って、良い思い出ができました。",
    "お気に入りの本を読んで、新しい世界を発見しました。"
  ].sample

  mood_keys = %w[very_bad bad normal good very_good]
  mood = mood_keys.sample

  GoodMemory.create!(
    content: content,
    date: date,
    mood: mood
  )
end

puts "サンプルデータの作成が完了しました！"
puts "作成された思い出の数: #{GoodMemory.count}"
