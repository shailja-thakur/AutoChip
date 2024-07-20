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

// Internal signal to store updated predict_history
logic [31:0] updated_predict_history;

// Always block to check clock and reset
always @(posedge clk or negedge areset) begin
    if (!areset) begin
        predict_history <= 32'b0;
    end else begin
        // Check train_mispredicted and predict_valid signals
        if (train_mispredicted) begin
            // Update predict_history with train_history and train_taken signals
            updated_predict_history <= train_history;
            if (train_taken) begin
                updated_predict_history <= updated_predict_history + 1;
            end
        end else if (predict_valid) begin
            // Update predict_history with predict_taken signal
            // Note: Here, predict_taken signal is assumed to be 1 bit wide
            updated_predict_history <= {predict_history[30:0], predict_taken};
        end else begin
            // No update required, set updated_predict_history to current predict_history
            updated_predict_history <= predict_history;
        end
        
        // Assign updated_predict_history to predict_history
        predict_history <= updated_predict_history;
    end
end

endmodule
