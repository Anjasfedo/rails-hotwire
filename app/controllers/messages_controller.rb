class MessagesController < ApplicationController
  before_action :set_room, only: %i[new create destroy edit update]
  before_action :set_message, only: %i[destroy edit update]

  def new
    @message = @room.messages.new
  end

  # POST /messages or /messages.json
  def create
    @message = @room.messages.new(message_params)

    respond_to do |format|
      if @message.save
        # format.turbo_stream
        format.html { redirect_to @room, notice: 'message was successfully createdddd.' }
        # format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /rooms/:room_id/messages/:id/edit
  def edit; end

  # PATCH/PUT /rooms/:room_id/messages/:id
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @room, notice: 'Message was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/:room_id/messages/:id
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to @room, notice: "Message was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_message
    @message = @room.messages.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end
end
