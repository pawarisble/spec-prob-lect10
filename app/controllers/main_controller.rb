class MainController < ApplicationController
  before_action :must_be_logged_in, only: %i[ user_Item ]
  def login
  end

  def create
    u = User.where(login: params[:login]).first
    if u && u.authenticate(params[:password])

      redirect_to main_user_Item_path

      session[:logged_in] = true
      session[:login_user_id] = u.id
    else 
      redirect_to main_login_path, notice: 'wrong username or password'
    end
  end

  def user_Item
    @user_id = session[:login_user_id]
    @user = User.where( id:@user_id ).first
  end

  def destroy
    reset_session
  end

  def user_item_del
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to main_user_Item_path
  end

  def shop_show_index
    @user = User.where(id: params[:id].to_i).first
    if(session[:logged_in])
      @user_login_id = User.where(id:  session[:login_user_id].to_i ).first
    end
  end

  def show_inventory
    @user_id = session[:login_user_id]
    @user = User.where( id:@user_id ).first
  end

  def buy_item
    @item = Item.find(params[:item_id])
    @buyer_id = session[:login_user_id]
    @buyer = User.where(id:session[:login_user_id]).first


    if(@item.stock <= 0)
      redirect_to '/shop/'+ params[:from_shop_user_id].to_s + '?buyzero=true'
    else 
      @item.stock -= 1
      @item.save
      Inventory.create(user_id: @buyer_id, item_id: @item.id, price: @item.price, timestamp: DateTime.current)
      redirect_to '/shop/'+ params[:from_shop_user_id].to_s + '?buysuccess=true'
    end
  end
  
end
