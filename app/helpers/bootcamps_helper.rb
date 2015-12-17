module BootcampsHelper

    def rating_average(bootcamp)
        if rating = bootcamp.bootcamp_reviews.blank?
            rating = 0
        else
            bootcamp.bootcamp_reviews.average(:rating).round(2)
        end
    end

    def current_user_commented?
        current_user.profile.bootcamp_reviews.where(bootcamp: @bootcamp).exists?
        
        # @bootcamp.bootcamp_reviews.each do |b|
        #     current_user.profile.bootcamp_reviews.each do |p|
        #         return false if p == b
        #     end
        # end
    end

    def bootcamp_owner?(bootcamp)
        current_user.profile.bootcamp_admin == bootcamp.id
    end

end
