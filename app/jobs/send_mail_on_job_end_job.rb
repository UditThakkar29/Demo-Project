class SendMailOnJobEndJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Project.all.each do |p|
      @project = p
      @users = p.users
      @sprint = p.board.sprints.where(current_sprint: true).first
      if @sprint.start_time.next_day(@sprint.duration).to_date == DateTime.now.to_date
        @users.each do |u|
          SprintMailer.sprint_end_notification(user: u, project: @project,sprint: @sprint).deliver_now
        end
      end
    end
  end
end
