class Order
  def initialize(args)
    @currency = args.fetch(:currency)
    @price = args.fetch(:price)
    @quantity = args.fetch(:quantity)
  end
end

class OpenAskOrder < Order
  # TODO IMPLEMENT
end

class CloseAskOrder < Order
  # TODO IMPLEMENT
end

class OpenBidOrder < Order
  # TODO IMPLEMENT
end

class CloseBidOrder < Order
  # TODO IMPLEMENT
end