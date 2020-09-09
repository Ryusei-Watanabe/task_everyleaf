
### userモデル
| カラム名 | データ型 |
----|----
| name | string |
| email | string |
| password_digest | string |

### taskモデル
| カラム名 | データ型 |
----|----
| title | string |
| content | text |
| state | string |
| deadline | datetime |
| user_id | integer |

### labelモデル
| カラム名 | データ型 |
----|----
| user_id | integer |
| task_id | integer |

# デプロイ手順
### アセットプリコンパイル
rails assets:precompile RAILS_ENV=production

### コミット
git add -A  
git commit -m "init"

### herokuにアプリ作成
heroku create

### heroku buildpackの追加
heroku buildpacks:set heroku/ruby  
heroku buildpacks:add --index 1 heroku/nodejs

### herokuにデプロイ
git push heroku master
