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
    
    // Variables for storing current and previous branch history
    logic [31:0] current_history;
    logic [31:0] previous_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the history counter to zero
            current_history <= 32'b0;
            previous_history <= 32'b0;
        end else begin
            // Shift the predict_history register
            if (predict_valid) begin
                current_history <= {predict_history[30:0], predict_taken};
            end
            
            // Handle branch misprediction
            if (train_mispredicted) begin
                // Concatenate previous history and actual branch result
                current_history <= {train_history[30:0], train_taken};
            end
        end
    end
    
    assign predict_history = current_history;
    
endmodule
