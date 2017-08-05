class RecommendationService

	def self.check_for_recommendations event
		recommendations = []
		
		amount_of_fernet = event.get_amount_of "Fernet"
		amount_of_coca = event.get_amount_of "Coca Cola"
		correct_amount_of_coca = amount_of_fernet*2
		if amount_of_coca < correct_amount_of_coca
			cocas_to_buy = correct_amount_of_coca - amount_of_coca
			recommendations << (Recommendation.create! item_name:"Coca Cola", amount:cocas_to_buy)
		end

		if needs_carbon event
			recommendations << (Recommendation.create! item_name:"Carbon", amount:1)
		end
		
		recommendations
	end

	private 	

		def self.needs_carbon event
			amount_of_asado = event.get_amount_of 'Tira de Asado'
			amount_of_vacio = event.get_amount_of 'Vacio'
			amount_of_carbon = event.get_amount_of 'Carbon'
			if ( (amount_of_asado + amount_of_vacio >= 1) && (amount_of_carbon == 0) )
				return true
			else
				return false
			end
		end

end
