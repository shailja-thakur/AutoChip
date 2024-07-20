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

    // Registers for storing the current state of the shift register and history
    logic [31:0] curr_state;
    logic [31:0] curr_history;
    
    always @(posedge clk or posedge areset) begin
        // Reset the shift register and history if areset is asserted
        if (areset) begin
            curr_state <= 0;
            curr_history <= 0;
        end
        // Shift in predict_taken when predict_valid is asserted
        else if (predict_valid) begin
            curr_state <= {curr_state[30:0], predict_taken};
        end
        // Load the branch history register with the history after a branch misprediction
        else if (train_mispredicted) begin
            curr_state <= {train_taken, train_history};
        end
    end
    
    // Assign the current state of the shift register to predict_history
    assign predict_history = curr_state;
    
endmodule
