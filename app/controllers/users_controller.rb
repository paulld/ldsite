class UsersController < ApplicationController

  # before_action :authenticate_user!, only: [:new, :editprofile]
  before_action :authenticate_user!

  def index
    @users = User.all.order('username ASC')
  end

  def index_trombi
    @users = User.all.order('username ASC')
  end

  def show
    @user = User.find_by(:username => params[:username])
    if @user.nil?
      # head 402
      # head 406
      redirect_to :root, flash: { error: 'Aucun membre de la famille ne correspond à ce code.' }
    else
      @user_country_name = Country.find_country_by_alpha2(@user.address_country).translations['fr'] unless !@user.address_country?
      render :show
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes( user_params )
    redirect_to user_show_url(current_user.username)
  end

  private

  # Use strong_parameters for attribute whitelisting
  # Be sure to update your create() and update() controller methods.

  def user_params
    params.require(:user).permit(:avatar, 
                                 :first_name, 
                                 :last_name, 
                                 :maiden_name,
                                 :birth_day,
                                 :birth_location,
                                 :is_married,
                                 :wedding_day,
                                 :wedding_location,
                                 :email,
                                 :secondary_email,
                                 :telephone,
                                 :secondary_telephone,
                                 :address_line1,
                                 :address_line2,
                                 :address_post_code,
                                 :address_city,
                                 :address_region,
                                 :address_country)
  end

end
