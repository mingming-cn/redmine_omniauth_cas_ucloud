# frozen_string_literal: true

require 'redmine'
require_relative 'lib/redmine_omniauth_cas_ucloud'
require_relative 'lib/redmine_omniauth_cas_ucloud/hooks'

# Plugin generic informations
Redmine::Plugin.register :redmine_omniauth_cas_ucloud do
  name 'Redmine Omniauth plugin for UCloud'
  description 'This plugin provides additional functionality for the redmine_omniauth_cas plugin, supporting the capability for automated user registration within the UCloud company environment.'
  author 'mingming.wang'
  author_url 'mailto:contact@mingming.wang'
  url 'https://github.com/mingming-cn/redmine_omniauth_cas_ucloud'
  version '3.3.0'
  requires_redmine :version_or_higher => '2.0.0'
  settings :default => { 'onthefly_register' => 'false' },
           :partial => 'settings/omniauth_cas_ucloud_settings'
end
