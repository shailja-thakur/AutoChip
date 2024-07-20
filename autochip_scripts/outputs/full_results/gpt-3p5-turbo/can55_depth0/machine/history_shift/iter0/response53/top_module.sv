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

// Registers to store the predict history and train history
reg [31:0] current_history;
reg [31:0] updated_history;

always @(posedge clk or negedge areset) begin
    if (areset == 0) begin
        // Reset the predict history to 0
        predict_history <= 0;
    end else begin
        if (train_mispredicted) begin
           // Update the predict history with train history and train taken signal
           updated_history <= (train_history << 1) | train_taken;
        end else if (predict_valid) begin
           // Update the predict history with the predict taken signal
           updated_history <= (predict_history << 1) | predict_taken;
        end
        // Assign the updated history to the current history
        current_history <= updated_history;
        // Assign the current history to the predict history
        predict_history <= current_history;
    end
end

endmodule
