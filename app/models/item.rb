class Item < ActiveRecord::Base

	def self.get_items
		if (Item.count == 0)
			Item.create_items
		end
		Item.all
	end

	private

		def self.create_items
	    Item.create! name:'Coca Cola'
	    Item.create! name:'Fernet'
	    Item.create! name:'Hielos'
	    Item.create! name:'Tira de Asado'
	    Item.create! name:'Vacio'
	    Item.create! name:'Chorizo'
	    Item.create! name:'Morcilla'
	    Item.create! name:'Provoleta'
	    Item.create! name:'Agua'
	    Item.create! name:'Carbon'
		end

end
