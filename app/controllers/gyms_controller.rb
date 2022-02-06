class GymsController < ApplicationController

    def index
        gyms = Gym.all
        render json: gyms, status: 200
    end
    
    def show
        gym = find_by_id
        if gym
            return render json: gym, status: 200
        else
            return render json: {error: "Gym not found"}, status: 404
        end
    end

    def update
        gym = find_by_id
        if gym
            gym.update!(gym_params)
            return render json: gym, status: 200
        else
            return render json: {error: "Gym not found"}, status: 404
        end
    rescue ActiveRecord::RecordInvalid => e
        return render json: {errors: e.record.errors.full_messages}, status:422
    end

    def destroy
        gym = find_by_id
        if gym
            gym.destroy
            return render json: {}
        else
            return render json: {error: "Gym not found"}, status: 404
        end
    end

    def create
        gym = Gym.create!(gym_params)
        if gym
            return render json: gym, status: 202
        else 
            return render json: {error: "Gym not created"}, status: 404
        end
    rescue ActiveRecord::RecordInvalid => e
        return render json: {errors: e.record.errors.full_messages}, status: 422
    end

    private

    def find_by_id
        Gym.find_by(id: params[:id])
    end

    def gym_params
        params.permit(:name, :address)
    end
    
end
