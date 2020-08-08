class ApplicationController < ActionController::Base
    ### for setting up strong parameter (1)
    before_action :configure_permitted_parameters, if: :devise_controller?
    ###

    protected
    ### for setting up strong parameter (2)
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :last_name_kanji, :first_name_kanji, :last_name_kana, :first_name_kana, :zip_code, :address, :phone_number])
    end
    ###
    
    ### redirection after sign_in/ sign_up/ sign_out
    def after_sign_in_path_for(resource_or_scope)
        if resource_or_scope.is_a?(Admin)
            admin_top_path
        else
            end_users_path
        end
    end
    def after_sign_up_path_for(resource_or_scope)
        end_users_path
    end
    def after_sign_out_path_for(resource_or_scope)
        if resource_or_scope == :end_user
            root_path
        else
            # new_end_user_session_path
            new_admin_session_path
        end
    end
    ###

end
