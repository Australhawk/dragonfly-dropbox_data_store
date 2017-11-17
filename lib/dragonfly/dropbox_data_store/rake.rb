# Ganked verbatim from: https://github.com/janko-m/paperclip-dropbox

require "dropbox_api"

module Dragonfly
  class DropboxDataStore
    module Rake
      extend self

      def authorize(app_key, app_secret, access_type)
        session = create_new_session(app_key, app_secret)

        puts "Visit this URL: #{session.authorize_url}"
        print "And after you approved the authorization paste it here: "


        auth_bearer = session.get_token assert_answer

        ##g7eEP-Vd0E8AAAAAAAAb3MqmTFVUDfM8K0tWE2JyD2Y
        dropbox_client = DropboxApi::Client.new(auth_bearer.token)
        account_info = dropbox_client.get_current_account

        puts <<-MESSAGE

        Authorization was successful. Here you go:
        access_token: #{auth_bearer.token}
        user_id: #{account_info.account_id}
        MESSAGE
      end

      def create_new_session(app_key, app_secret)
        DropboxApi::Authenticator.new(app_key, app_secret)
      end

      def assert_answer
        answer = STDIN.gets.strip
        return answer
        exit if answer == "n"
      end
    end
  end
end
