module top_module
(
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);

    // Internal signal to hold the updated predict history
    logic [31:0] updated_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the predict history to 0
            predict_history <= 0;
        end else begin
            if (train_mispredicted) begin
                // Update the predict history with train_history and train_taken
                updated_history <= {predict_history[30:0], train_taken};
                predict_history <= updated_history;
            end else if (predict_valid) begin
                // Update the predict history with predict_taken
                updated_history <= {predict_history[30:0], predict_taken};
                predict_history <= updated_history;
            end
        end
    end

endmodule
