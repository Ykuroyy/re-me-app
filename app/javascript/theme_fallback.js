// フォールバック用のテーマ切り替え機能
document.addEventListener('DOMContentLoaded', function() {
  // Stimulusが動作しない場合のフォールバック
  if (typeof window.Stimulus === 'undefined') {
    function applyTheme(theme) {
      let bg, color;
      if (theme === 'pink') {
        bg = 'linear-gradient(135deg, #ffeef8 0%, #f0e6ff 100%)';
        color = '#8b5a8c';
      } else if (theme === 'purple') {
        bg = 'linear-gradient(135deg, #ede7f6 0%, #d1c4e9 100%)';
        color = '#6a1b9a';
      } else if (theme === 'green') {
        bg = 'linear-gradient(135deg, #e0f7fa 0%, #b2dfdb 100%)';
        color = '#00695c';
      }
      document.body.style.background = bg;
      document.body.style.color = color;
      localStorage.setItem('theme', theme);
    }

    // テーマボタンにイベントリスナーを追加
    document.querySelectorAll('.theme-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        applyTheme(this.dataset.theme);
      });
    });

    // 保存されたテーマを適用
    const saved = localStorage.getItem('theme') || 'pink';
    applyTheme(saved);
  }
}); 