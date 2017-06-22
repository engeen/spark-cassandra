# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value


  #======provision config ============
  server "root@212.24.39.19", no_release: true, user: "root", roles: %w{mmp}, ssh_options: { auth_methods: %w(publickey) }

  #server "root@212.24.39.18", no_release: true, user: "root", roles: %w{spark}, ssh_options: { auth_methods: %w(publickey) }
  #server "root@212.24.39.20", no_release: true, user: "root", roles: %w{spark_slave}, ssh_options: {  auth_methods: %w(publickey) }
  #server "root@212.24.39.21", no_release: true, user: "root", roles: %w{spark_slave}, ssh_options: {  auth_methods: %w(publickey) }
  #server "root@212.24.39.22", no_release: true, user: "root", roles: %w{spark_slave}, ssh_options: {  auth_methods: %w(publickey) }


  # server "root@212.24.39.34", no_release: true, user: "root", roles: %w{cassandra}, ssh_options: { auth_methods: %w(publickey) }
# server "root@212.24.39.35", no_release: true, user: "root", roles: %w{cassandra}, ssh_options: { auth_methods: %w(publickey) }
# server "root@212.24.39.36", no_release: true, user: "root", roles: %w{cassandra}, ssh_options: { auth_methods: %w(publickey) }
# server "root@212.24.39.37", no_release: true, user: "root", roles: %w{cassandra}, ssh_options: { auth_methods: %w(publickey) }
  # server "root@212.24.39.38", no_release: true, user: "root", roles: %w{cassandra}, ssh_options: { auth_methods: %w(publickey) }


 #server "212.24.39.19", user: "deployer", roles: %w{app web db}, ssh_options: { auth_methods: %w(publickey) }









  #server "root@212.24.39.19", no_release: true, user: "root", roles: %w{mmp}, ssh_options: { auth_methods: %w(publickey) }
  #server "212.24.39.19", user: 'deployer', roles: %w{app web db}, ssh_options: { auth_methods: %w(publickey password) } 

  #server "62.213.76.76", no_release: true, user: "root", roles: %w{spark}, ssh_options: { auth_methods: %w(publickey) }

  #server "root@62.213.76.77", no_release: true,roles: %w{postgres redis pmon web}, ssh_options: { auth_methods: %w(publickey) } 
  #server "root@62.213.76.78", no_release: true,roles: %w{pmon}, ssh_options: { auth_methods: %w(publickey) } 
  #server "root@217.23.156.98", no_release: true,roles: %w{pmon}, ssh_options: { auth_methods: %w(publickey) } 
  #server "root@217.23.156.99", no_release: true,roles: %w{pmon}, ssh_options: { auth_methods: %w(publickey) } 
  #server "root@217.23.156.100", no_release: true,roles: %w{pmon}, ssh_options: { auth_methods: %w(publickey) } 
  #server "root@217.23.156.101", no_release: true,roles: %w{pmon}, ssh_options: { auth_methods: %w(publickey) } 
  #server "root@217.23.156.102", no_release: true,roles: %w{pmon}, ssh_options: { auth_methods: %w(publickey) } 

  #======deployment config ==============
  # server "62.213.76.77", user: 'deployer', roles: %w{app web db sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 
  # server "62.213.76.78", user: 'deployer', roles: %w{app sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 
  # server "217.23.156.98", user: 'deployer', roles: %w{app sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 
  # server "217.23.156.99", user: 'deployer', roles: %w{app sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 
  # server "217.23.156.100", user: 'deployer', roles: %w{app sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 
  # server "217.23.156.101", user: 'deployer', roles: %w{app sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 
  # server "217.23.156.102", user: 'deployer', roles: %w{app sidekiq}, ssh_options: { auth_methods: %w(publickey password) } 



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
