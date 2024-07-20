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
    // Registers to store the branch prediction history
    logic [31:0] history_reg;
    
    always @(posedge clk or negedge areset) begin
        if (!areset) begin
            // Reset the history register to 0
            history_reg <= 0;
        end else begin
            // Check if the previous prediction was mispredicted
            if (train_mispredicted) begin
                // Update the history register with the actual branch history and taken signal
                history_reg <= {train_taken, train_history[30:0]};
            end else if (predict_valid) begin
                // Update the history register with the predict_taken signal
                history_reg <= {predict_taken, history_reg[30:0]};
            end
        end
    end
    
    // Assign the predict_history output
    assign predict_history = history_reg;
    
endmodule
