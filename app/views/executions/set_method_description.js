$("#method_description").html('<%= j render partial: "executions/method_description", locals: {description: @description, method: @method} %>');