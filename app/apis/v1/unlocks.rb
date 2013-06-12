class APIv1
  class Unlocks < Grape::API

    version 'v1', using: :path

    resource :unlocks do

      # GET /unlocks.json
      desc "Returns list of all Unlocks."
      get '/' do
        @unlocks = Unlock.all
        render_custom "api_v1/unlocks/index", @unlocks, 200
      end

      # GET /unlocks/1.json
      desc "Returns a single Unlock record by ID"
      get "/:id" do
        @unlock = Unlock.where(id: params[:id]).first
        render_custom "api_v1/unlocks/show", @unlock, 200
      end

    end
  end
end