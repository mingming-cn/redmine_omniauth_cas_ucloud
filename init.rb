# frozen_string_literal: true

require 'redmine'
require_relative 'lib/redmine_omniauth_cas_ucloud'
require_relative 'lib/redmine_omniauth_cas_ucloud/hooks'

# Plugin generic informations
Redmine::Plugin.register :redmine_omniauth_cas_ucloud do
  name 'Redmine Omniauth plugin for UCloud'
  description 'This plugin adds Omniauth support to Redmine'
  author 'mingming.wang'
  author_url 'mailto:contact@mingming.wang'
  url 'https://github.com/mingming-cn'
  version '3.3.0'
  requires_redmine :version_or_higher => '2.0.0'
end
