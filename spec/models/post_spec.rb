require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
  end

  describe 'ポストの保存' do
    context 'ポストが投稿できる場合' do
      it '画像とテキストを投稿できる' do
        expect(@post).to  be_valid
      end
      it 'テキストのみで投稿できる' do
        @post.image = ''
        expect(@post).to be_valid
      end
    end
    context 'ポストが投稿できない場合' do
      it 'タイトルが空では投稿できない' do
        @post.title = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Title can't be blank")
      end
      it 'テキストが空では投稿できない' do
        @post.text = ''
        @post.valid?
        expect(@post.errors.full_messages).to include("Text can't be blank")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @post.user = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('User must exist')
      end
    end
  end
end
