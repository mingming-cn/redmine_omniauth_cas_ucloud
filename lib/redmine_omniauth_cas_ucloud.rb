module RedmineOmniauthCasUcloud
  class << self
    def settings_hash
      Setting["plugin_redmine_omniauth_cas_ucloud"]
    end

    def onthefly_register
      settings_hash["onthefly_register"]
    end
  end
end
