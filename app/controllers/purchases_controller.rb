class PurchasesController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @user_purchase = UserPurchase.new
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      pay_item
      @user_purchase.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :new
    end
  end

  private
  def purchase_params
    params.require(:user_purchase).permit(:postcode, :area_id, :city, :block, :building, :phone_number, :user_id, :item_id).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECLET_KEY"]
    Payjp::Charge.create(
      amount: Item.find(params[:price]),
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end

