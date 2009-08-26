# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails_root_session',
  :secret      => '42dff086b0c6806e725f39269a2b991b758e4f20a0ed4ea6b920d121ef1ecdeb0c01144c0c4b2084c8b5631f82d94c2b5038e36ed1d4e480bdf39a7e161b52f7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
