class ClientsController < ApplicationController

    def index
        clients = Client.all
        render json: clients
    end

    def show
        client = find_by_id
        if client
            return render json: client, status: 200
        else
            return render json: {error: "No such client"}, status: 404
        end
    end

    # here is a way to show "charges" without using a serializer
    # def show
    #     client = find_by_id
    #     if client
    #         return render json: client, status: 200, include: {memberships: {only: :charge}}
    #     else
    #         return render json: {error: "No such client"}, status: 404
    #     end
    # end

    def update
        client = find_by_id
        if client
            client.update!(client_params)
            return render json: client, status: 202
        else 
            return render json: {error: "No such client"}, status: 404
        end
    rescue ActiveRecord::RecordInvalid => e
        return render json: {errors: e.record.errors.full_messages}, status: 422   
    end


    
    private
    
    def find_by_id
        client = Client.find_by(id: params[:id])
    end

    def client_params
        params.permit(:name, :age)
        
    end

end
