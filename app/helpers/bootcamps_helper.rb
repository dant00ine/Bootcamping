module BootcampsHelper

    def rating_average(bootcamp)
        if rating = bootcamp.bootcamp_reviews.blank?
            rating = 0
        else
            bootcamp.bootcamp_reviews.average(:rating).round(2)
        end
    end
    
end
