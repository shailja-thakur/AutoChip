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

    // Signals for the global history shift register
    reg [31:0] history_register;
    reg [31:0] shifted_history;

    always @(posedge clk or posedge areset) begin
        // Asynchronous reset
        if (areset) begin
            history_register <= 0;
        end
        // Update the history register
        else if (predict_valid) begin
            // Shift the history register
            shifted_history <= {history_register[29:0], predict_taken};
            
            // Update the history register with the shifted history
            history_register <= shifted_history;
        end
        // Load the branch history register after a misprediction
        else if (train_mispredicted) begin
            // Concatenate the train_history and train_taken
            shifted_history <= {train_history, train_taken};
            
            // Update the history register with the shifted history
            history_register <= shifted_history;
        end
    end
    
    // Output the predict history
    assign predict_history = history_register;

endmodule
