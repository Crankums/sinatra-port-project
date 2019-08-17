class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, Proc.new { File.join(root, "../views/") }
        enable :sessions
        set :session_secret, SESSION_SECRET
    end

    get '/' do
        erb :index
    end
    
    helpers do
        def logged_in?
            !!session[:user_id]
        end

        def current_user
            User.find_by(id: session[:user_id])
        end

        def authenticate
            if !logged_in?
                redirct '/login'
            end
        end
    end
end