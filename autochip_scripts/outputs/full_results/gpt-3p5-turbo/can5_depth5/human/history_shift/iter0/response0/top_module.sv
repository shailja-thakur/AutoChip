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
    
    logic [31:0] history_register;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset history counter to zero
            history_register <= 0;
        end else begin
            // Shift in predict_taken from LSB side if predict_valid is true
            if (predict_valid) begin
                history_register <= {history_register[30:0], predict_taken};
            end
            // Load history register with train_history concatenated with train_taken if train_mispredicted is true
            else if (train_mispredicted) begin
                history_register <= {train_history, train_taken};
            end
            // No update if both predict_valid and train_mispredicted are false
            else begin
                history_register <= history_register;
            end
        end
    end
    
    assign predict_history = history_register;
    
endmodule
