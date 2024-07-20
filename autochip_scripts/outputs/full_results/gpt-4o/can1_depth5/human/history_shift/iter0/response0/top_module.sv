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

    logic [31:0] history; // Internal history register
    
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            history <= 32'b0;
        end else if (train_mispredicted) begin
            // When a misprediction is detected, load the train_history concatenated with train_taken
            history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Shift in the predict_taken value from the LSB side
            history <= {history[30:0], predict_taken};
        end
    end
    
    // Assign the internal history register to the output
    assign predict_history = history;

endmodule
