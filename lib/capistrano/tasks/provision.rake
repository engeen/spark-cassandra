require 'pry'
namespace :provision do


  # desc 'Knife solo prepare servers'
  # task :prepare,[:provision_roles] do |task, args|
  #   _provision_roles = args.has_key?(:provision_roles) ? args.extras << args[:provision_roles] : false
  #   run_locally do
  #     Bundler.with_clean_env do
  #       env.servers.each do |server|
  #         #binding.pry
  #         if _provision_roles
  #           next unless server.properties.roles.to_a.inject(false) {|res,r| res || _provision_roles.include?(r.to_s) } 
  #         end
  #         #binding.pry 
  #         _pk_setting = "-i #{server.ssh_options[:keys][0]}" if server.ssh_options.has_key?(:keys) && server.ssh_options[:keys].is_a?(Array)
  #         system "cd chef && knife solo prepare #{server.user}@#{server.hostname} #{_pk_setting}"
  #       end

  #     end
  #   end
  # end


  desc 'Knife solo cook servers'
  task :build,[:provision_roles] do |task, args|
    _provision_roles = args.has_key?(:provision_roles) ? args.extras << args[:provision_roles] : false
    #binding.pry 
    run_locally do
      Bundler.with_clean_env do
        env.servers.each do |server|
#          binding.pry
          if _provision_roles
            next unless server.properties.roles.to_a.inject(false) {|res,r| res || _provision_roles.include?(r.to_s) } 
          end
          #binding.pry 
          _pk_setting = "-i#{server.ssh_options[:keys][0]}" if server.ssh_options.has_key?(:keys) && server.ssh_options[:keys].is_a?(Array)
          _server_roles = server.properties.roles.to_a.map{|r| "role[#{r}]"}.join(",")#server.properties.roles.to_a.join(",")#
          _command = "cd chef && knife solo prepare #{server.user}@#{server.hostname} #{_pk_setting}  -r#{_server_roles} -E#{fetch(:stage).to_s}"
          pp _command
          system  _command
          _command = "cd chef && knife solo cook #{server.user}@#{server.hostname} #{_pk_setting} -r#{_server_roles} -E#{fetch(:stage).to_s}"
          pp _command
          system  _command
        end

      end
    end
  end



end