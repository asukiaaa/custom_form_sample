module InputModel
  extend ActiveSupport::Concern

  def self.create
    # ▼▼▼ 入力用のクラスを動的生成 ▼▼▼
    active_model = Class.new do |_klass|
      include ActiveModel::Model
      include ActiveModel::Conversion
      include ActiveModel::AttributeMethods
      include ActiveRecord::Callbacks

      attr_accessor :items

      def initialize(items)
        @items = items
        items.each do |item|
          item.init_input(singleton_class)
        end
      end

      # attributes= の代わり
      def input_attributes=(hash)
        hash.each do |key, value|
          value = value.delete_if(&:blank?) if value.is_a?(Array)
          self.send("#{key}=", value)
        end
      end

      def to_data
        @items.map do |item|
          value_hash = item.attr_names.map { |n| [n, send(n)] }.to_h
          item.field_input_params(value_hash)
        end
      end
    end
    # ▲▲▲ 入力用のクラスを動的生成 ▲▲▲

    Object.const_set(:Input, active_model)
  end
end
