require 'octrouble/cli'

RSpec.describe Octrouble::Cli do
  describe '#issues' do
    subject(:octrouble) { Octrouble::Cli.new }

    it 'rails/rails リポジトリ（1ページ目）の Issues が出力される' do
      expect(octrouble.issues).not_to be nil
    end

    context '--page 引数が入力されている場合' do
      it 'そのページの Issues が出力される'
    end

    context 'Issues が 0件だった場合' do
      it 'Issue is not found. という結果が出力される'
    end

    context '該当するリポジトリが存在しない場合' do
      it 'Repository is not found. という結果が出力される'
    end
  end

  describe '#get_issues' do
    it 'Issues のデータを配列で返す'

    context 'Issues が 0件だった場合' do
      it '空の配列を返す'
    end

    context '該当するリポジトリが存在しない場合' do
      it 'エラーが発生する'
      it 'nil を返す'
    end
  end
end
