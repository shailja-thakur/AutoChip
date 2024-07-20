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

// Gshare branch predictor parameters
parameter PHT_SIZE = 128;
parameter HIST_LEN = 7;

// PHT (Pattern History Table)
reg [1:0] pht[PHT_SIZE-1:0];

// Global branch history register
reg [HIST_LEN-1:0] global_history;

// Logic for branch prediction
always @(*) begin
    if (predict_valid) begin
        // Hash PC and global history to get PHT index
        predict_history = global_history;
        predict_taken = (pht[predict_pc ^ global_history][1]);
    end else begin
        predict_taken = 0;
        predict_history = 0;
    end
end

// Logic for branch training
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end else begin
        if (train_valid) begin
            // Update global history
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= (global_history << 1) | train_taken;
            end

            // Update PHT
            pht[train_pc ^ train_history] <= (train_taken) ? (pht[train_pc ^ train_history] == 2'b11 ? 2'b11 : pht[train_pc ^ train_history] + 1'b1) :
                                                            (pht[train_pc ^ train_history] == 2'b00 ? 2'b00 : pht[train_pc ^ train_history] - 1'b1);
        end
    end
end

endmodule
