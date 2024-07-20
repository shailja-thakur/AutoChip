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

    // Internal register to hold the history
    logic [31:0] history_reg;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the history register
            history_reg <= 32'b0;
        end else if (train_mispredicted) begin
            // On misprediction, update the history with train_history and train_taken
            history_reg <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // On valid prediction, shift in the predict_taken value
            history_reg <= {history_reg[30:0], predict_taken};
        end
    end

    // Output the current history register value
    assign predict_history = history_reg;

endmodule
