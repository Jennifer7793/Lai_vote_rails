class CandidatesController < ApplicationController
  before_action :find_candidate, only: [:edit, :update, :vote, :destroy]

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to candidates_path, notice: 'Successful added!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: 'Candidate Updated!'
    else 
      render :edit
    end
  end

  def vote
    @candidate.vote_logs.create(ip_address: request.remote_ip)
    redirect_to candidates_path, notice: "Voted!"
  end

  def destroy
    @candidate.destroy
    redirect_to candidates_path, notice: "Candidate deleted!"
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end

  def find_candidate
    @candidate = Candidate.find_by(id: params[:id])
  end
end
