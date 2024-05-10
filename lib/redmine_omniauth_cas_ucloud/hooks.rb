require 'net/http'

module RedmineOmniauthCasUcloud
  class Hooks < Redmine::Hook::ViewListener
    def controller_account_before_cas_login(context = {})
      unless RedmineOmniauthCasUcloud.settings_hash["onthefly_register"]
        return true
      end

      auth = context[:auth]
      if User.find_by_login(auth["uid"]).present?
        return true
      end

      uri = URI("https://web_api.ucloudadmin.com/?action=SSO.GetStaffInfo")
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Get.new(uri.request_uri)
      http.use_ssl = true
      req['Cookie'] = CGI::Cookie.new('INNER_AUTH_TOKEN', context[:cookies]["INNER_AUTH_TOKEN"]).to_s
      res = http.request(req)

      json = JSON.parse(res.body)
      ret_code = json["ret_code"]
      if ret_code != 0
        flash[:error] = "Failed to request cas info, ret_code: #{ret_code}"
        return false
      end

      email = json["staff_info"]["staff_email"]
      name_cn = json["staff_info"]["staff_name_cn"]
      name_cn_first = name_cn[1..name_cn.length]
      name_cn_last = name_cn[0]

      if email == "" || name_cn_first == "" || name_cn_last == ""
        flash[:error] = "Failed to request cas info, invalid email or name_cn"
        return false
      end

      user=User.new(:status=>1,:mail_notification=>"only_my_events",:language=>"")
      user.login=auth["uid"]
      user.lastname=name_cn_last
      user.firstname=name_cn_first
      user.mail=email
      user.admin=0
      user.auth_source_id=1
      user.save
    end
  end
end
