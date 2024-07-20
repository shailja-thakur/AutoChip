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

    // Internal register to hold the branch history state
    logic [31:0] history;

    // Assign predict_history to the internal register
    assign predict_history = history;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset to zero
            history <= 32'b0;
        end else if (train_mispredicted) begin
            // On misprediction, concatenate train_history with train_taken
            history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // On valid prediction, shift in predict_taken from LSB side
            history <= {history[30:0], predict_taken};
        end
    end

endmodule
