class ItemsController < ApplicationController

	def index
		items = Item.get_items
		expose items, each_serializer: ItemSerializer
  end

end
