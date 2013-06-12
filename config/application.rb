require 'yaml'
require 'rabl'

# ---- SETUP THE DATABASE CONNECTION
db = YAML.load(File.open('db/config.yml'))[Goliath.env.to_s]
puts "Establishing db connection: #{db.inspect}"
ActiveRecord::Base.establish_connection(db)

# ---- CONFIGURE RABL FOR JSON OUTPUT
Rabl.configure do |config|
  # Commented as these are defaults
  # config.cache_all_output = false
  # config.cache_sources = Rails.env != 'development' # Defaults to false
  # config.cache_engine = Rabl::CacheEngine.new # Defaults to Rails cache
  # config.escape_all_output = false
  # config.json_engine = nil # Any multi_json engines or a Class with #encode method
  # config.msgpack_engine = nil # Defaults to ::MessagePack
  # config.bson_engine = nil # Defaults to ::BSON
  # config.plist_engine = nil # Defaults to ::Plist::Emit
  config.include_json_root = false
  # config.include_msgpack_root = true
  # config.include_bson_root = true
  # config.include_plist_root = true
  # config.include_xml_root  = false
  # config.include_child_root = true
  # config.enable_json_callbacks = false
  # config.xml_options = { :dasherize  => true, :skip_types => false }
  config.view_paths = ['app/views']
end


# ---- CONFIGURE i18N FOR LOCALIZATION
I18n.load_path += Dir['app/locale/*.yml']
I18n.locale = :en
# this sets up fallback support, meaning they'll get 'en'
# if we can't find a translation for their locale
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)