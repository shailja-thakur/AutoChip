module top_module(
    input clk,
    input areset, 

    input predict_valid,
    input [6:0] predict_pc,
    output reg predict_taken, 
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history, 
    input [6:0] train_pc
);

// 7-bit global history register
reg [6:0] global_history;

// 128-entry pattern history table (PHT)
reg [1:0] pht [127:0];

// Combinational logic for prediction
always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        predict_history = global_history;
        // Predict the branch direction using the PHT entry
        predict_taken = (pht[predict_pc ^ global_history][1]);
    end
    else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Sequential logic for training
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10; // Initialize PHT to weakly not-taken
        end
    end
    else begin
        if (train_valid) begin
            // Update the PHT entry based on the actual branch outcome
            if (train_taken) begin
                // Increment the PHT counter (saturating)
                if (pht[train_pc ^ train_history] != 2'b11)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1'b1;
            end
            else begin
                // Decrement the PHT counter (saturating)
                if (pht[train_pc ^ train_history] != 2'b00)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1'b1;
            end

            // Update the global history register
            if (train_mispredicted) begin
                // If the branch was mispredicted, recover the global history to the state before the misprediction
                global_history <= train_history;
            end
            else begin
                // Otherwise, update the global history register with the actual branch outcome
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
