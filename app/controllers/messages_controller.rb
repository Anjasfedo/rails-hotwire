class MessagesController < ApplicationController
  before_action :set_room, only: %i[ new create ]

  def new
    @message = @room.messages.new
  end

  # POST /messages or /messages.json
  def create
    @message = @room.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @room, notice: "message was successfully created." }
        # format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:room_id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:content)
    end
end
