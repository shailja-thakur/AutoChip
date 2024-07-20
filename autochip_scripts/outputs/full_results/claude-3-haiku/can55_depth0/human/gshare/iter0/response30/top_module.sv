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

// 7-bit PC and 7-bit global history, hashed (using xor) into a 7-bit index
wire [6:0] pht_index = predict_pc ^ predict_history;

// 128-entry table of two-bit saturating counters
reg [1:0] pht [127:0];

// Global branch history register
reg [6:0] branch_history;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history <= 7'b0;
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b01; // Initialize all entries to weakly not taken
        end
    end
    else begin
        // Predict branch direction
        if (predict_valid) begin
            predict_taken <= (pht[pht_index] >= 2'b10); // Predict taken if counter is >= 2
            predict_history <= branch_history;
        end

        // Train branch predictor
        if (train_valid) begin
            // Update pattern history table (PHT)
            if (train_taken) begin
                pht[pht_index] <= (pht[pht_index] < 2'b11) ? pht[pht_index] + 1'b1 : 2'b11; // Increment if not saturated
            end
            else begin
                pht[pht_index] <= (pht[pht_index] > 2'b00) ? pht[pht_index] - 1'b1 : 2'b00; // Decrement if not saturated
            end

            // Update branch history register
            if (train_mispredicted) begin
                branch_history <= train_history; // Recover history to state before misprediction
            end
            else begin
                branch_history <= (branch_history << 1) | train_taken; // Shift in the actual branch outcome
            end
        end
    end
end

endmodule
