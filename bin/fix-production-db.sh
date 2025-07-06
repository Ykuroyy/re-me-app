#!/usr/bin/env bash
# Fix production database from local environment

echo "Production Database Fix Script"
echo "=============================="
echo ""
echo "このスクリプトは、ローカルからRenderの本番データベースを修正します。"
echo ""

# Check if DATABASE_URL is provided
if [ -z "$DATABASE_URL" ]; then
    echo "ERROR: DATABASE_URL環境変数が設定されていません。"
    echo ""
    echo "使用方法:"
    echo "1. RenderのダッシュボードからDATABASE_URLをコピー"
    echo "2. 以下のコマンドを実行:"
    echo "   DATABASE_URL='your_database_url_here' ./bin/fix-production-db.sh"
    echo ""
    echo "例:"
    echo "   DATABASE_URL='postgres://user:pass@host:port/db' ./bin/fix-production-db.sh"
    exit 1
fi

echo "DATABASE_URLが設定されています。"
echo ""

# Set production environment
export RAILS_ENV=production

echo "本番環境に設定しました (RAILS_ENV=production)"
echo ""

# Test database connection
echo "データベース接続をテスト中..."
if bundle exec rails runner "ActiveRecord::Base.connection.execute('SELECT 1')" 2>/dev/null; then
    echo "✓ データベース接続成功"
else
    echo "✗ データベース接続失敗"
    echo "DATABASE_URLを確認してください。"
    exit 1
fi

echo ""

# Check current migration status
echo "現在のマイグレーション状況を確認中..."
bundle exec rake db:migrate:status

echo ""

# Ask user what to do
echo "以下のオプションから選択してください:"
echo "1) マイグレーションのみ実行 (推奨)"
echo "2) データベースを完全にリセット (注意: すべてのデータが削除されます)"
echo "3) テーブルの存在確認のみ"
echo ""

read -p "選択してください (1-3): " choice

case $choice in
    1)
        echo ""
        echo "マイグレーションを実行中..."
        bundle exec rake db:migrate
        echo ""
        echo "テーブルの存在を確認中..."
        bundle exec rails runner "puts 'Table exists: ' + GoodMemory.connection.table_exists?('good_memories').to_s"
        ;;
    2)
        echo ""
        echo "WARNING: データベースを完全にリセットします。すべてのデータが削除されます。"
        read -p "続行しますか? (y/N): " confirm
        if [[ $confirm =~ ^[Yy]$ ]]; then
            echo "データベースをリセット中..."
            bundle exec rake db:drop
            bundle exec rake db:create
            bundle exec rake db:migrate
            echo ""
            echo "テーブルの存在を確認中..."
            bundle exec rails runner "puts 'Table exists: ' + GoodMemory.connection.table_exists?('good_memories').to_s"
        else
            echo "キャンセルされました。"
        fi
        ;;
    3)
        echo ""
        echo "テーブルの存在を確認中..."
        bundle exec rails runner "puts 'Table exists: ' + GoodMemory.connection.table_exists?('good_memories').to_s"
        ;;
    *)
        echo "無効な選択です。"
        exit 1
        ;;
esac

echo ""
echo "完了しました！" 