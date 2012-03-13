require "active_attr/typecasting/big_decimal_typecaster"
require "active_attr/typecasting/boolean"
require "active_attr/typecasting/boolean_typecaster"
require "active_attr/typecasting/date_time_typecaster"
require "active_attr/typecasting/date_typecaster"
require "active_attr/typecasting/float_typecaster"
require "active_attr/typecasting/integer_typecaster"
require "active_attr/typecasting/object_typecaster"
require "active_attr/typecasting/string_typecaster"
require "active_support/concern"

module ActiveAttr
  # Typecasting provides methods to typecast a value to a different type
  #
  # The following types are supported for typecasting:
  # * BigDecimal
  # * Boolean
  # * Date
  # * DateTime
  # * Float
  # * Integer
  # * Object
  # * String
  #
  # @since 0.5.0
  module Typecasting
    extend ActiveSupport::Concern

    # @private
    TYPECASTERS = {
      BigDecimal => BigDecimalTypecaster,
      Boolean    => BooleanTypecaster,
      Date       => DateTypecaster,
      DateTime   => DateTimeTypecaster,
      Float      => FloatTypecaster,
      Integer    => IntegerTypecaster,
      Object     => ObjectTypecaster,
      String     => StringTypecaster,
    }

    # Typecasts a value using a Class
    #
    # @param [Class] type The type to cast to
    # @param [Object] value The value to be typecasted
    #
    # @return [Object, nil] The typecasted value or nil if it cannot be
    #   typecasted
    #
    # @since 0.5.0
    def typecast_attribute(type, value)
      raise ArgumentError, "a Class must be given" unless type
      return value if value.nil?

      if typecaster = TYPECASTERS[type]
        typecaster.new.call(value)
      end
    end
  end
end
