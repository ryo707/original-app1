# require 'rails_helper'

# RSpec.describe 'コメント投稿', type: :system do
#   before do
#     @post = FactoryBot.create(:post)
#     @comment = Faker::Lorem.sentence
#   end

#   it 'ログインしたユーザーはポスト詳細ページでコメント投稿できる' do
#     # ログインする
      # sign_in(@post.user)
#     # ツイート詳細ページに遷移する
#     visit post_path(@post)
#     # フォームに情報を入力する
#     fill_in 'comment_text', with: @comment
#     # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
#     expect{
#       find('input[name="commit"]').click
#     }.to change { Comment.count }.by(1)
#     # 詳細ページにリダイレクトされることを確認する
#     expect(current_path).to eq(post_path(@post))
#     # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
#     expect(page).to have_content @comment
#   end
# end
