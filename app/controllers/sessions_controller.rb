class SessionsController < ApplicationController
  before_action :set_session, only: %i[ show edit update destroy ]

  # GET /sessions or /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1 or /sessions/1.json
  def show
    @frame = Frame.new

    @players = Player
    .select("PLAYERS.*, LAST_FRAME.*")
    .joins('LEFT OUTER JOIN (SELECT * FROM FRAMES GROUP BY PLAYER_ID ORDER BY FRAMES.FRAME DESC, FRAMES.TURN DESC LIMIT 1) as LAST_FRAME ON LAST_FRAME.player_id = PLAYERS.id')
    .where({session:params[:id]})
    # .order('LAST_FRAME.FRAME DESC, LAST_FRAME.TURN DESC')

    puts @players.inspect()
  end

  # #POST /sessions/update_score
  # def update_score
    
  #   Frame.new({knocked_pins:params[:score],player:params[:player_id],frame:params[:last_frame] + 1,turn:params[:last_turn] + 1})
  # end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions or /sessions.json
  def create
    @session = Session.new(session_params)
    respond_to do |format|
      if @session.save
        format.html { redirect_to '/players/new/'+@session[:id].to_s, notice: "Session was successfully created." }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
    puts @session
  end

  # PATCH/PUT /sessions/1 or /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: "Session was successfully updated." }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1 or /sessions/1.json
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: "Session was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:session).permit(:players_count)
    end
end
