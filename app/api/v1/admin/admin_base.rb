module Api
  class V1
    class Admin
      class AdminBase < Api::SecuredBase
        before do
          check_permissions("admin")
        end
      end
    end
  end
end
