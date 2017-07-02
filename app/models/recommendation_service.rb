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

		recommendations
	end

end
