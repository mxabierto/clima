class V1::ThingsController < V1::BaseController
  respond_to :json

  def index
    @things = Thing.all
    respond_with @things
  end

  def show
    respond_with Thing.find(params[:id])
  end

  def create
    respond_with Thing.create(thing_params)
  end

  def update
    respond_with Thing.update(params[:id], thing_params)
  end

  def destroy
    respond_with Thing.destroy(params[:id])
  end

  private

  # Only allow a trusted parameter "white list" through.
  def thing_params
    params.require(:thing).permit(:name, :age, :price, :expires, :discharged_at, :description, :published, :gender)
  end

end
