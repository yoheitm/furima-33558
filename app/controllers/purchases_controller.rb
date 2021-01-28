class PurchasesController < ApplicationController
  def new
    @item = Item.find(params[:item_id])
    @user_purchase = UserPurchase.new
  end

  def create
    @user_purchase = UserPurchase.new(purchase_params)
    if @user_purchase.valid?
      @user_purchase.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  private
  def purchase_params
    params.require(:user_purchase).permit(:postcode, :area_id, :city, :block, :building, :phone_number, :user_id, :item_id)
  end
end

