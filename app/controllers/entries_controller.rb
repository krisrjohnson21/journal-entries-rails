class EntriesController < ApplicationController
  def show
    @entry = Entry.find(params["id"])
    @journal = @entry.journal
  end

  def new
    @entry = Entry.new
    @journal = Journal.find(params["journal_id"])
  end

  def create
    @entry = Entry.new(entry_params)
    @journal = Journal.find(params["journal_id"])
    @entry.journal = @journal

    if @entry.save
      flash[:notice] = "New entry was saved successfully"
      redirect_to @journal
    else
      flash.now[:error] = @entry.errors.full_messages.to_sentence
      render :new
    end
  end

  private
    def entry_params
      params.require("entry").permit("title", "body")
    end
end
