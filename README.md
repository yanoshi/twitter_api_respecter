# 使い方
モックAPIを設置したいディレクトリ(Webサーバーのスタティックなファイル領域)でgit cloneをした後に

```bash
bundle install
ruby run.rb
```

を実行してください。apiディレクトリ以下にGETメソッドで叩くことの出来るTwitter APIのルーティング構造を保ったjson群が自動生成されています。