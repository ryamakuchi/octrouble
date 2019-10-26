# Octrouble

Github API から Issues のデータを取得し、取得内容を CSV 形式で出力する CLI アプリケーションです。

## Installation

アプリケーションの `Gemfile` に以下の行を追加してください。

```ruby
gem 'octrouble'
```

```sh
# 以下を実行
$ bundle

# もしくは、次のように自分でインストールします
$ gem install octrouble
```

## Usage

以下のように実行すると、リポジトリの Issues から最新 30件（1ページ分）を取得します。

```sh
$ bundle exec octrouble issues user/repo
```

`user/repo` 引数を省略すると、デフォルトでは `rails/rails` のリポジトリから Issues を取得します。

### Options

`--page` 引数（もしくはエイリアス `-p`）を指定すると、指定したページの情報を取得できます。

```sh
$ bundle exec octrouble issues octokit/octokit.rb --page 2
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ryamakuchi/octrouble. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
