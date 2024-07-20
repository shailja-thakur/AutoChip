module top_module(
    input clk,
    input areset,
    
    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,
    
    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

reg [1:0] pht [0:127];
reg [6:0] global_history;
reg [6:0] predict_history_reg;
reg predict_taken_reg;
reg [6:0] predict_pc_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all the registers
        for (integer i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b00;
        end
        global_history <= 7'b0;
        
        // Clear the output registers
        predict_history_reg <= 7'b0;
        predict_taken_reg <= 1'b0;
    end else begin
        if (predict_valid) begin
            // Update the prediction history register
            predict_history_reg <= global_history;
            
            // Calculate the index for the PHT based on the xor of the PC and history
            // Use the index to access the corresponding saturating counter value in the PHT
            // Determine the predict_taken value based on the counter value
            predict_taken_reg <= (pht[predict_pc_reg ^ global_history] > 1'b1);
        end
        
        if (train_valid) begin
            // Update the PHT with the actual branch outcome
            // If the branch was taken, increment the saturating counter
            // If the branch was not taken, decrement the saturating counter
            // Ensure the counter value stays within the range of 2'b00 and 2'b11
            pht[train_pc ^ train_history] <= train_taken ? $signed(pht[train_pc ^ train_history]) + 1'b1 : $signed(pht[train_pc ^ train_history]) - 1'b1;
            
            // Update the global history register
            // If the branch was mispredicted, reset the history to the state immediately after the mispredicting branch completes execution
            global_history <= train_mispredicted ? {1'b0, train_history[5:0]} : {1'b0, global_history[5:1]};
        end
    end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;
assign predict_pc_reg = predict_valid ? predict_pc : 7'b0;

endmodule
