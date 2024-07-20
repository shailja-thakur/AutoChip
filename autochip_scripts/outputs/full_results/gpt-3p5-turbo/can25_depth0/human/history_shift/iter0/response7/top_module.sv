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

    // Define signals
    logic [31:0] history_reg;
    logic [31:0] rollback_history;
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset history register to zero
            history_reg <= 0;
        end else begin
            if (train_mispredicted) begin
                // Load history register with rollback history
                history_reg <= {train_history, train_taken};
            end else if (predict_valid) begin
                // Shift in predict_taken
                history_reg <= {history_reg[30:0], predict_taken};
            end else begin
                // No changes to history register
                history_reg <= history_reg;
            end
        end
    end
    
    always_comb begin
        if (train_mispredicted) begin
            // Set rollback history as current history
            rollback_history = history_reg;
        end else begin
            // Set rollback history as train_history
            rollback_history = {train_history, train_taken};
        end
    end
    
    // Assign outputs
    assign predict_history = history_reg;
    
endmodule
