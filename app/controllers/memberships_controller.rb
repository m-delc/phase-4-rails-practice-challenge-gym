class MembershipsController < ApplicationController

    def create
        membership = Membership.create!(membership_params)
        if membership
            return render json: membership, status: 201
        else 
            return render json: {error: "Couldn't create membership"}, status: 422
        end        
    end

    private

    def membership_params
        params.permit(:charge, :client_id, :gym_id)
    end
end
