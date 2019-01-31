module Api
  class V1
    class Profile < Api::SecuredBase
      post "/changepassword" do
        old_password = params[:old_password]
        new_password_1 = params[:new_password_1]
        new_password_2 = params[:new_password_2]

        check_new_passwords(new_password_1, new_password_2)

        found_user = User.find_by_user_name(request.env[:user_name])

        check_old_password(found_user, old_password)

        found_user.password = new_password_1

        found_user.save

        logger.info "User '#{found_user.user_name}' password changed"

        content_type :json
        {result: true}.to_json
      end

      private

      def check_new_passwords(new_password_1, new_password_2)
        return_404("New passwords don't match") unless new_password_1 == new_password_2

        return_404("New password length should have at least six chars") if new_password_1.nil? || new_password_1.length < 6
      end

      def check_old_password(user, old_password)
        return_404("Old password is not valid") if user.password. != old_password
      end
    end
  end
end
