class ClassinfosController < ApplicationController
  def index
    @classes = current_user.classinfos
    json_response(@classes)
  end

  def create
    @classinfo=Userclass.create!(user:current_user,classinfo:Classinfo..create!(classinfo_params))
    json_response(@classinfo, :created)
  end

  # GET /todos/:id
  def show
    json_response(@todo)
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def classinfo_params
    # whitelist params
    params.permit(:time,:duration_in_min,:name,:level,:general_info,:preparation_info,:arrival_ahead_in_min,:additional_info,:vacancies,
                  :is_available,:bookable_before,:bookable_after)
  end


  def set_todo
    @todo = Todo.find(params[:id])
  end
end
