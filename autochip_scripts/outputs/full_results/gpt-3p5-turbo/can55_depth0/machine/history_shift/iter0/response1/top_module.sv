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

// Internal signal to hold the updated predict_history value
logic [31:0] updated_predict_history;

// Always block to update the predict_history based on the input signals
always_ff @(posedge clk or negedge areset) begin
    if (!areset) begin
        // Reset the predict_history to 0 when areset is asserted
        updated_predict_history <= 0;
    end else begin
        if (train_mispredicted) begin
            // Update predict_history with train_history and train_taken when train_mispredicted is asserted
            updated_predict_history <= {train_history, train_taken};
        end else if (predict_valid) begin
            // Update predict_history with predict_taken when predict_valid is asserted
            updated_predict_history <= {predict_history[30:0], predict_taken};
        end
    end
end

// Assign the updated predict_history value to the output signal
assign predict_history = updated_predict_history;

endmodule
