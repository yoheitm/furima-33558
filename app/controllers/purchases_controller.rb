class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_purchase, only: [:new, :create]

  def new
    @user_purchase = UserPurchase.new
    redirect_to root_path if (current_user.id == @item.user_id) || @item.purchase.present?
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      pay_item
      @user_purchase.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def purchase_params
    params.require(:user_purchase).permit(:postcode, :area_id, :city, :block, :building, :phone_number).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end
end
