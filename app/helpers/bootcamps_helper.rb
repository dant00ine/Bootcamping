module BootcampsHelper

    def rating_average(bootcamp)
        if rating = bootcamp.bootcamp_reviews.blank?
            rating = 0
        else
            bootcamp.bootcamp_reviews.average(:rating).round(2)
        end
    end

    def current_user_commented?
        @bootcamp.bootcamp_reviews.each do |b|
            current_user.profile.bootcamp_review.each do |p|
                if p == b
                    return false
                end
            end
        end
    end
    
end
