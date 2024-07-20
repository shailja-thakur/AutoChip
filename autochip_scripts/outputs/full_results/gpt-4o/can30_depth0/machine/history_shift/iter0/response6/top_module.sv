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
    // Intermediate register to hold the prediction history
    logic [31:0] predict_history_reg;

    // Synchronous logic to update prediction history
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the prediction history to 0
            predict_history_reg <= 32'b0;
        end
        else begin
            if (train_mispredicted) begin
                // Update the prediction history with the training signals in case of misprediction
                predict_history_reg <= {train_history[30:0], train_taken};
            end
            else if (predict_valid) begin
                // Update the prediction history with the prediction taken signal
                predict_history_reg <= {predict_history_reg[30:0], predict_taken};
            end
        end
    end

    // Output the current prediction history
    assign predict_history = predict_history_reg;

endmodule
