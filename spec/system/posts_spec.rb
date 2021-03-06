require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post_title = Faker::Lorem.sentence
    @post_text = Faker::Lorem.sentence
    @post_image = Faker::Lorem.sentence
  end
  context 'ポスト投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'post_image', with: @post_image
      fill_in 'post_title', with: @post_title
      fill_in 'post_text', with: @post_text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(posts_path)
      # 「投稿が完了しました」の文字があることを確認する
      expect(page).to have_content('投稿完了')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@post_image});']"
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@post_text)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('投稿する')
    end
  end
end

# ※ここからidに関しての修正が必要

# RSpec.describe 'ツイート編集', type: :system do
#   before do
#     @post1 = FactoryBot.create(:post)
#     @post2 = FactoryBot.create(:post)
#   end
#   context 'ポスト編集ができるとき' do
#     it 'ログインしたユーザーは自分が投稿したポストの編集ができる' do
#       # ポスト1を投稿したユーザーでログインする
        # sign_in(@post1.user)
#       # ポスト1に「編集」へのリンクがあることを確認する
#       expect(
#         all('.more')[1].hover
#       ).to have_link '編集', href: edit_post_path(@post.id)
#       # 編集ページへ遷移する
#       visit edit_post_path(@post1)
#       # すでに投稿済みの内容がフォームに入っていることを確認する
#       expect(
#         find('#post_image').value
#       ).to eq(@post.image)
#       expect(
#         find('#post_title').value
#       ).to eq(@post.title)
#       expect(
#         find('#post_text').value
#       ).to eq(@post_text)
#       # 投稿内容を編集する
#       find_in 'post_image', with: "#{@post1.image}+編集した画像URL"
#       find_in 'post_title', with: "#{@post1.title}+編集したタイトル"
#       find_in 'post_text', with: "#{@post1.text}+編集したテキスト"
#       # 編集してもPostモデルのカウントは変わらないことを確認する
#       expect{
#         find('input[name="commit"]').click
#       }.to change { Post.count }.by(0)
#       # 編集完了画面に遷移したことを確認する
#       expect(current_path).to eq(post_path(@post1))
#       # 「更新完了」の文字があることを確認する
#       expect(page).to have_content('更新が完了しました')
#       # トップページに遷移する
#       visit root_path
#       # トップページには先ほど変更した内容のポストが存在することを確認する（画像）
#       expect(page).to have_selector ".content_post[style='background-image: url(#{@post1.iamge}+編集した画像URL);']"
#       # トップページには先ほど変更した内容のポストが存在することを確認する（テキスト）
#       expect(page).to have_content("#{@post1.text}+編集したテキスト")
#     end
#   end
#   context 'ポスト編集ができないとき' do
#     it 'ログインしたユーザーは自分以外が投稿したポストの編集画面には遷移できない' do
#       # ポスト1を投稿したユーザーでログインする
        # sign_in(@post1.user)
#       # ポスト2に「編集」へのリンクがないことを確認する
#       expect(
#         all('.more')[0].hover
#       ).to have_no_link '編集', href: edit_post_path(@post2)
#     end
#     it 'ログインしていないとツイートの編集画面には遷移できない' do
#       # トップページにいる
#       visit root_path
#       # ポスト1に「編集」へのリンクがないことを確認する
#       expect(
#         all('.more')[1].hover
#       ).to have_no_link '編集', href: edit_post_path(@post1)
#       # ポスト2に「編集」へのリンクがないことを確認する
#       expect(
#         all('.more')[0].hover
#       ).to have_no_link '編集', href: edit_post_path(@post2)
# #     end
# #   end
# end

# RSpec.describe 'ポスト削除', type: :system do
#   before do
#     @post1 = FactoryBot.create(:post)
#     @post2 = FactoryBot.create(:post)
#   end
#   context '削除ができるとき' do
#     it 'ログインしたユーザーは自らが投稿したポストの削除ができる' do
#       # ポスト1を投稿したユーザーでログインする
        # sign_in(@post1.user)
#       # ポスト1に「削除」へのリンクがあることを確認する
#       expect(
#         all('.more')[1].hover
#       ).to have_link '削除', href: post_path(@post1)
#       # 投稿を削除するとレコードの数が1減ることを確認する
#       expect{
#         all('.more')[1].hover.find_link('削除', href: post_path(@post1)).click
#       }.to change { Post.count }.by(-1)
#       # 削除完了画面に遷移したことを確認する
#       expect(current_path).to eq(post_path(@post1))
#       # 「削除が完了しました」の文字があることを確認する
#       expect(page).to have_content('削除完了')
#       # トップページに遷移する
#       visit root_path
#       # トップページにはポスト1の内容が存在しないことを確認する（画像）
#       expect(page).to have_no_selector ".content_post[style='background-image: url(#{@post1.image});']"
#       # トップページにはポスト1の内容が存在しないことを確認する（テキスト）
#       expect(page).to have_no_content("#{@post1.text}")
#     end
#   end
#   context 'ポスト削除ができないとき' do
#     it 'ログインしたユーザーは自分以外が投稿したポストの削除ができない' do
#       # ポスト1を投稿したユーザーでログインする
        # sign_in(@post1.user)
#       # ポスト2に「削除」へのリンクがないことを確認する
#       expect(
#         all('.more')[0].hover
#       ).to have_no_link '削除', href: post_path(@post2)
#     end
#     it 'ログインしていないとポストの削除ボタンがない' do
#       # トップページに移動する
#       visit root_path
#       # ポスト1に「削除」へのリンクがないことを確認する
#       expect(
#         all('.more')[1].hover
#       ).to have_no_link '削除', href: post_path(@post1)
#       # ポスト2に「削除」へのリンクがないことを確認する
#       expect(
#         all(".more")[0].hover
#       ).to have_no_link '削除', href: post_path(@post2)
#     end
#   end
# end

# RSpec.describe 'ツイート詳細', type: :system do
#   before do
#     @tweet = FactoryBot.create(:tweet)
#   end
#   it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
#     # ログインする
      # sign_in(@post.user)
#     # ツイートに「詳細」へのリンクがある
#     expect(
#       all(".more")[0].hover
#     ).to have_link '詳細', href: tweet_path(@tweet)
#     # 詳細ページに遷移する
#     visit tweet_path(@tweet)
#     # 詳細ページにツイートの内容が含まれている
#     expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet.image});']"
#     expect(page).to have_content("#{@tweet.text}")
#     # コメント用のフォームが存在する
#     expect(page).to have_selector 'form'
#   end
#   it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
#     # トップページに移動する
#     visit root_path
#     # ツイートに「詳細」へのリンクがある
#     expect(
#       all(".more")[0].hover
#     ).to have_link '詳細', href: tweet_path(@tweet)
#     # 詳細ページに遷移する
#     visit tweet_path(@tweet)
#     # 詳細ページにツイートの内容が含まれている
#     expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet.image});']"
#     expect(page).to have_content("#{@tweet.text}")
#     # フォームが存在しないことを確認する
#     expect(page).to have_no_selector 'form'
#     # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
#     expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
#   end
# end