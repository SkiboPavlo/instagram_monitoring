#
class TwitterUser
  include Mongoid::Document

  field :name, type: String
  field :id_str, type: String
  field :screen_name, type: String
  field :profile_location, type: String
  field :url, type: String
  field :entities, type: String
  field :protected, type: String
  field :created_at, type: Date
  field :connections, type: Array
  field :utc_offset, type: String
  field :geo_enabled, type: String
  field :verified, type: String
  field :status, type: String
  field :contributors_enabled, type: String
  field :is_translator, type: String
  field :profile_background_image_url, type: String
  field :profile_background_image_url_https, type: String
  field :profile_background_tile, type: String
  field :profile_image_url, type: String
  field :profile_image_url_https, type: String
  field :profile_banner_url_https, type: String
  field :profile_banner_url, type: String
  field :profile_use_background_image, type: String
  field :has_extended_profile, type: String
  field :default_profile, type: String
  field :default_profile_image, type: String
  field :following, type: String
  field :follow_request_sent, type: String
  field :notifications, type: String
  field :translator_type, type: String
  field :is_translation_enabled, type: Boolean
  field :description, type: String
  field :email, type: String
  field :favourites_count, type: Integer
  field :followers_count, type: Integer
  field :friends_count, type: Integer
  field :lang, type: String
  field :listed_count, type: Integer
  field :location, type: String
  field :name, type: String
  field :profile_background_color, type: String
  field :profile_link_color, type: String
  field :profile_sidebar_border_color, type: String
  field :profile_sidebar_fill_color, type: String
  field :profile_text_color, type: String
  field :statuses_count, type: Integer
  field :time_zone, type: String
  field :tc_offset, type: Integer
end
