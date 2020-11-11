# 概要
ライブ好きのためのマッチングアプリ」
好きなアーティストを通じて、友達を見つけるアプリです。

# URL
https://fesapp.ga/

# 制作の背景
音楽アーティストのライブや、フェスにいくのが好きな20代でした。
遠方に友達を連れて、フェスにいくと「駐車場の確保していないよ」、「宿泊施設ないよ」、「俺、お気にのアーティストのグッズを全部買いに行くわ！設営してて！」、「疲れたから帰りたい」など、意見がばらけて、せっかくの楽しいイベントなのにしらけてしまうことがありました。

これは、イベントへの熱量の違いから発生しているのでは！？と思い、
同じ熱量の仲間を探せるサービス作りを目指しました。

# 機能一覧
* ユーザーの登録・ログイン機能（devise)
* ユーザーとユーザーのフォロー機能
* ユーザー相互フォローによるマッチング機能（論理式でマッチングしていると判断させる）
* ユーザー同士のメッセージのやり取り
* ユーザーからアーティストをお気に入り登録（フォロー機能）
* Spotify APIを使用して、アーティストを検索
* 登録済みアーティストの検索
＊ ページネーション機能（kaminari)

#　環境・使用技術

## フロントエンド
* semantic-ui-sass (2.4.2.0)
* JavaScript
* React

## バックエンド
* ruby 2.6.6
* Rails 6.0.3.4

## 開発環境
* Docker/Docker-compose
* MyAQL2

## テスト
* Rspec
* CircleCIを用いてdocker-composeでコンテナを構築し自動テスト

## 本番環境
* AWS (EC2、RDS for MySQL、Route53, ACM, ALB)
* MySQL2
* Nginx、 Puma

##  インフラ構成図
![画面フローERD-Page-3](https://user-images.githubusercontent.com/49685825/97828908-c7de1c00-1d0b-11eb-9d3c-e68b73bfd132.jpg)

## その他使用技術
* 外部API(Spotify API)
* Freenomでドメイン名取得

## ER図
![画面フローERD-ERD](https://user-images.githubusercontent.com/49685825/97828897-c14fa480-1d0b-11eb-85c8-36f7b4aac484.jpg)

## 画面フロー設計図

![画面フローERD-画面フロー](https://user-images.githubusercontent.com/49685825/97828899-c280d180-1d0b-11eb-9fee-cbbbf19a52f4.jpg)
##  至らぬポイント
* テスト数が少ない
* チャットの非同期通信化の未実施（WebSocketを使用予定）
* Circle CIで自動テスト後の自動デプロイを未実施
* チーム開発を意識したgithubの扱い

# About me
新卒で自動車会社で実験、生産技術をしておりました。
2020年7月末より本格的にWebエンジニア目指して勉強しております。


