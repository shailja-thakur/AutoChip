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

    // Define internal signals and registers
    logic [31:0] history;
    
    // Reset the history counter to zero on positive edge triggered asynchronous reset
    always_ff @(posedge clk, posedge areset)
    begin
        if (areset)
            history <= 0;
    end
    
    // Shift in the predict_taken to update the branch history for the predicted branch
    always_ff @(posedge clk)
    begin
        if (predict_valid)
            history <= {history[30:0], predict_taken};
        
        // Load the branch history register with the history after a branch misprediction
        if (train_mispredicted)
            history <= {train_history[30:0], train_taken};
    end
    
    // Assign the value of the branch history register to the predict_history output
    assign predict_history = history;

endmodule
