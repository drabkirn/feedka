module Admin
  class ReportsController < Admin::ApplicationController
    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    ## Before showing the report to admin, decrypt the content
    ## The feedback giver has authorized admin to see the content
    def find_resource(param)
      @report = Report.find(param.to_i)
      @report.content = Encryption.decrypt_data(@report.content)
      @report
    end
  end
end
