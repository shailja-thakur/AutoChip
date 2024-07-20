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

// Register to store the history of branch predictions
reg [31:0] history;

always @(posedge clk, negedge areset) begin
    if (areset == 0) begin
        // Reset the predict_history signal to 0
        predict_history <= 0;
    end else begin
        if (train_mispredicted == 1) begin
            // Update the predict_history signal with train_history and train_taken signals
            history <= train_history;
            if (train_taken == 1) begin
                history[31:1] <= {history[30:0], 1};
            end else begin
                history[31:1] <= {history[30:0], 0};
            end
        end else if (predict_valid == 1) begin
            // Update the predict_history signal with the predict_taken signal
            if (predict_taken == 1) begin
                history[31:1] <= {history[30:0], 1};
            end else begin
                history[31:1] <= {history[30:0], 0};
            end
        end
        // Assign the updated history to the predict_history signal
        predict_history <= history;
    end
end

endmodule
