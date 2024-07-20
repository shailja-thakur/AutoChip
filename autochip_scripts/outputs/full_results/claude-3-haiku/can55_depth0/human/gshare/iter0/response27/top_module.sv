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

reg [1:0] pht[127:0]; // Pattern History Table
reg [6:0] global_history;

always @(*) begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        predict_taken = pht[predict_pc ^ global_history][1];
        predict_history = global_history;
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize PHT to weakly not-taken
        end
    end else begin
        if (train_valid) begin
            // Update PHT based on actual branch outcome
            if (train_taken) begin
                pht[train_pc ^ train_history][1] <= 1'b1; // Taken
            end else begin
                pht[train_pc ^ train_history][1] <= 1'b0; // Not taken
            end

            // Recover global history on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
