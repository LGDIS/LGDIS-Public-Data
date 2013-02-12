LGDIS-Public-Data
=================

import2memcachedツール
---------------
初期データ(CSVファイル)をmemcacheサーバにロードします。

### 使い方

1. import2memcached.rbファイル内のmemcacheサーバ指定、ロード対象CSVファイルのディレクトリ指定を書き換えておきます。
1. ruby import2memcached.rb

### 備考

* エラー時は発生時点で中断します。エラー原因を除去し、memcacheサーバを再起動したのち再度実施してください。
