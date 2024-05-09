module RedmineOmniauthCasUcloud
  class Hooks < Redmine::Hook::ViewListener
    def controller_account_before_cas_login(context = {})
      auth = context[:auth]
      if User.find_by_login(auth["uid"]).blank?
        user=User.new(:status=>1,:mail_notification=>"only_my_events",:language=>"")
        user.login=auth["uid"]
        user.lastname=auth["uid"].split('.').last
        user.firstname=auth["uid"].split('.').first
        user.mail="#{auth["uid"]}@ucloud.cn"
        user.admin=0
        user.auth_source_id=1
        user.save
      end
    end
  end
end
