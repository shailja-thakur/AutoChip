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

    // Internal register to store the prediction history
    logic [31:0] predict_history_reg;

    // Always block for clock and asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the prediction history to 0
            predict_history_reg <= 32'b0;
        end else begin
            // Check if the misprediction occurred
            if (train_mispredicted) begin
                // Update prediction history with the training history and whether branch was taken
                predict_history_reg <= (predict_history_reg << 1) | train_taken;
            end else if (predict_valid) begin
                // Update prediction history with the prediction taken signal
                predict_history_reg <= (predict_history_reg << 1) | predict_taken;
            end
        end
    end

    // Assign the internal register to the output
    assign predict_history = predict_history_reg;

endmodule
