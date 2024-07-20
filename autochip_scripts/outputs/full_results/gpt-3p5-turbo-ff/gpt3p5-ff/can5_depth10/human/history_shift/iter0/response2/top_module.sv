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
    
    // Define registers
    reg [31:0] history_register;
    reg [31:0] updated_history;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Reset the history counter to zero
            history_register <= 32'b0;
        end else if (predict_valid) begin
            // Shift in predict_taken from the LSB side to update the branch history
            history_register <= {history_register[30:0], predict_taken};
        end else if (train_mispredicted) begin
            // Load the branch history register with the history after the completion of the mispredicted branch
            updated_history <= {train_history[30:0], train_taken};
            history_register <= updated_history;
        end
    end
    
    // Output the predict_history
    assign predict_history = history_register;
    
endmodule
