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

reg [1:0] pht [127:0]; // 128-entry pattern history table
reg [6:0] global_history; // 7-bit global branch history register

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        predict_history = global_history;
        predict_taken = (pht[predict_pc ^ global_history][1]);
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not taken
        end
    end else begin
        if (train_valid) begin
            // Update the PHT based on the actual branch outcome
            if (train_taken) begin
                if (pht[train_pc ^ train_history] != 2'b11)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1;
            end else begin
                if (pht[train_pc ^ train_history] != 2'b00)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1;
            end

            // Update the global history register
            if (train_mispredicted) begin
                // Recover the global history register to the state immediately after the mispredicting branch
                global_history <= train_history;
            end else begin
                // Update the global history register with the actual branch outcome
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
