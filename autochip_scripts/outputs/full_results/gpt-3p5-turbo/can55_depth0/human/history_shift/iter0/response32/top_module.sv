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

// Global history shift register
reg [31:0] history;

// Counter to keep track of the youngest branch
reg [4:0] counter;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset history and counter to zero
        history <= 0;
        counter <= 0;
    end else begin
        // Shift in predict_taken when predict_valid is high
        if (predict_valid) begin
            // Shift history to the right
            history <= {predict_history[30:0], predict_taken};
        end
        
        // Load the branch history on misprediction
        if (train_mispredicted) begin
            // Concatenate train_history and train_taken
            history <= {train_history, train_taken};
            counter <= 0; // Reset counter
        end
        
        // Update counter on every clock cycle
        counter <= counter + 1;
    end
end

// Assign predict_history with the value of history at the counter index
assign predict_history = history[counter];

endmodule
