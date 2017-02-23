class Api::V1::UserDatasController < Api::ApiController
  skip_before_action :verify_authenticity_token

  def create
    unless User.exists?(email: params[:email])
      user = User.create(user_params)
      render(
        json: {
          status: ((user.save) ? 201 :204 )
        }
      )
    end
  end

  def user_params
    params.permit(
      :first_name,
      :last_name,
      :birth_date,
      :birth_sign,
      :gender,
      :email,
      :contact_no
    )
  end

end
