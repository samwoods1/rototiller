require 'rototiller/utilities/color_text'

class EnvVar
  MESSAGE_TYPES = {:nodefault_noexist=>0, :exist=>1, :default_noexist=>2}
  include ColorText

  attr_accessor :var, :message, :default

  # @return [Symbol] the debug level of the message, ':warning', ':error', ':info'
  attr_reader :message_level

  # @return [true, nil] if the state of the EnvVar requires the task to stop
  attr_reader :stop

  # Creates a new instance of EnvVar, holds information about the ENV in the environment
  # @param [Hash] attribute_hash hash of information about the environment variable
  # @option attribute_hash [String] :name The environment variable
  # @option attribute_hash [String] :default The default value for the environment variable
  # @option attribute_hash [String] :message A message describing the use of this variable
  def initialize(attribute_hash)
    raise(ArgumentError, 'A name must be supplied to add_env') unless attribute_hash[:name]
    @var = attribute_hash[:name]
    @message = attribute_hash[:message]
    @default = attribute_hash[:default]
    set_message_level
    set_value
  end

  # The formatted message to be displayed to the user
  # @return [String] the EnvVar's message, formatted for color and meaningful to the state of the EnvVAr
  def message
    if message_level == :error
      level_str = 'ERROR:'
    elsif message_level == :info
      level_str = 'INFO:'
    elsif message_level == :warning
      level_str = 'WARNING:'
    end
    message_prepend = "#{level_str} The environment variable: '#{@var}'"
    if get_message_type == MESSAGE_TYPES[:default_noexist]
      return yellow_text("#{message_prepend} is not set. Proceeding with default value: '#{@default}': #{@message}")
    end
    if get_message_type == MESSAGE_TYPES[:exist]
      return green_text("#{message_prepend} was found with value: '#{ENV[@var]}': #{@message}")
    end
    if get_message_type == MESSAGE_TYPES[:nodefault_noexist]
      return red_text("#{message_prepend} is required: #{@message}")
    end
  end

  private
  def set_value
    ENV[@var] = @default unless ENV[@var]
  end

  def check
    ENV.key?(@var)
  end

  def get_message_type
    if !@default && !check
      # ENV is not Present and it has no default value
      MESSAGE_TYPES[:nodefault_noexist]
    elsif check
      # ENV is present; may or may not have default, who cares
      MESSAGE_TYPES[:exist]
    elsif @default && !check
      # ENV is not present and it has default value
      MESSAGE_TYPES[:default_noexist]
    end
  end

  def set_message_level
    if get_message_type == MESSAGE_TYPES[:nodefault_noexist]
      # ENV is not Present and it has no default value
      @message_level = :error
      @stop = true
    elsif get_message_type == MESSAGE_TYPES[:exist]
      # ENV is present and it has no default value
      @message_level = :info
    elsif get_message_type == MESSAGE_TYPES[:default_noexist]
      # ENV is not present and it has default value
      @message_level = :info
    else
      raise 'EnvVar: message type not supported'
    end
  end
end