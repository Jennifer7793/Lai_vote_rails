class CandidatesController < ApplicationController
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
    @candidate = Candidate.find_by(id:params[:id])
  end

  def update
    @candidate = Candidate.find_by(id:params[:id])
    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: 'Candidate Updated!'
    else 
      render :edit
    end
  end

  def destroy
    @candidate = Candidate.find_by(id:params[:id])
    @candidate.destroy
    redirect_to candidates_path, notice: "Candidate deleted!"
  end

  private
  def candidate_params
    params.require(:candidate).permit(:name, :age, :party, :politics)
  end
end
