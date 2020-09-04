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
