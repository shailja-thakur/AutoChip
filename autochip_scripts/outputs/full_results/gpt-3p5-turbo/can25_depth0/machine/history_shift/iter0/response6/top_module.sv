module top_module (
    input clk,
    input areset,
    input predict_valid,
    input predict_taken,
    output logic [31:0] predict_history,
    
    input train_mispredicted,
    input train_taken,
    input [31:0] train_history
);
    
    // Registers for predict_history and train_history
    logic [31:0] predict_history_reg;
    logic [31:0] train_history_reg;
    
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            // Reset predict_history
            predict_history_reg <= 0;
        end else begin
            // Update predict_history based on train_mispredicted and predict_valid signals
            if (train_mispredicted) begin
                predict_history_reg <= {train_history, train_taken};
            end else if (predict_valid) begin
                predict_history_reg <= {predict_history_reg[30:0], predict_taken};
            end
        end
    end
    
    // Assign predict_history
    assign predict_history = predict_history_reg;
    
endmodule
