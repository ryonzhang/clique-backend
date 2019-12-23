# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :set_user, only: [:friend,:invite,:accept,:reject,:defriend]

  STATUS_INVITING=0
  STATUS_INVITE_ACCEPTED=1
  STATUS_INVITE_REJECTED=2
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def update
    success = current_user.update!(user_update_params)
    json_response(success, :accepted)
  end

  def friends
    if params[:user_id]!=nil then
      return json_response(User.find(params[:user_id]).friends, :accepted)
    else
      return json_response(current_user.friends, :accepted)
    end
  end


  def friend
    friend = Friendship.where(user:current_user,friend:@user).count >0 || Friendship.create!(user:current_user,friend:@user)
    Friendship.where(user:@user,friend:current_user).count >0 || Friendship.create!(user:@user,friend:current_user)
    json_response(friend, :created)
  end

  def defriend
    friend = Friendship.where(user:current_user,friend:@user).count >0 || Friendship.delete_all(user:current_user,friend:@user)
    Friendship.where(user:@user,friend:current_user).count >0 || Friendship.delete_all(user:@user,friend:current_user)
    json_response(friend, :accepted)
  end

  def invite
    invite = Invite.where(user:current_user,intended_friend:@user).count >0 || Invite.create!(user:current_user,intended_friend:@user,status:STATUS_INVITING)
    json_response(invite, :created)
  end

  def accept
    invites = Invite.where(user:current_user,intended_friend:@user)
    return json_response({},:internal_server_error) if invites.count==0
    return json_response(invites.update(status:STATUS_INVITE_ACCEPTED),:accepted)
  end

  def reject
    invites = Invite.where(user:current_user,intended_friend:@user)
    return json_response({},:internal_server_error) if invites.count==0
    return json_response(invites.update(status:STATUS_INVITE_REJECTED),:accepted)
  end

  def requested_friends
    invites = Invite.where(intended_friend:current_user,status:STATUS_INVITING)
    return json_response(invites.map{|invite| invite.user},:accepted)
  end


  private

  def user_params
    params.permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :role
    )
  end
  def user_update_params

    params.permit(
        :name,
        :email,
        :first_name,
        :last_name,
        :gender,
        :birthday,
        :city,
        :nationality,
        :phone_number,
        :emergency_name,
        :emergency_contact,
        :is_searchable,
        :is_previous_classes_visible,
        :is_coming_classes_visible,
        :is_favorite_institutions_visible,
        :username,
        :country,
        :province,
        :street,
        :building,
        :unit,
        :zipcode
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end