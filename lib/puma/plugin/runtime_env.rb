# frozen_string_literal: true

require "puma/plugin"

# Graciously, from https://github.com/rails/rails/blob/94b5cd3a20edadd6f6b8cf0bdf1a4d4919df86cb/activesupport/lib/active_support/inflector/methods.rb#L69
def camelize(term, uppercase_first_letter = true)
  string = term.to_s

  string = string.sub(/^[a-z\d]*/) { |match| match.capitalize }

  string.gsub!(/(?:_|(\/))([a-z\d]*)/i) { "#{$1}#{$2.capitalize}" }
  string.gsub!("/".freeze, "::".freeze)
  string
end

Puma::Plugin.create do
  def config(c)
    adapter_name = ENV["PUMA_RUNTIME_ENV_ADAPTER"] || "k8s"

    begin
      require "puma/runtime_env/#{adapter_name}"
    rescue LoadError => e
      puts "Could not find an adapter for puma-runtime_env"
      puts e
      return
    end

    adapter = Puma::RuntimeEnv.const_get("#{camelize(adapter_name)}").new
    poll_interval = Integer(ENV["PUMA_RUNTIME_ENV_INTERVAL"]) rescue 10

    restricted_envs = ["PUMA_RUNTIME_ENV"]
    other_restricted_envs = ENV.fetch("PUMA_RUNTIME_ENV_RESTRICTED", [])
    restricted_envs.push(*other_restricted_envs)

    if workers_supported?
      c.on_worker_boot do
        Thread.new do

          loop do
            sleep(poll_interval)

            new_envs = adapter.get_env

            new_envs.each do |key, value|
              next if key.start_with? *restricted_envs

              ENV[key] = value
            end
          end

        end
      end
    end

  end
end

