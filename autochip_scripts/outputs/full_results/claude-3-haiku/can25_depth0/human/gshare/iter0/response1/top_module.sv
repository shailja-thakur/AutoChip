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

// 128-entry pattern history table (PHT) of 2-bit saturating counters
reg [1:0] pht [127:0];

// Global branch history register
reg [6:0] global_history;

// Hash function to index the PHT
function [6:0] hash(input [6:0] pc, input [6:0] history);
    begin
        hash = pc ^ history;
    end
endfunction

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all 2-bit counters to weakly not-taken (01)
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01;
        end
        // Reset global history register to all zeros
        global_history <= 7'b0000000;
    end
    else begin
        // Update global history register on prediction
        if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end

        // Train the branch predictor
        if (train_valid) begin
            // Update the PHT entry
            pht[hash(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b00;

            // Recover the global history register on misprediction
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

// Provide branch prediction
always @* begin
    if (predict_valid) begin
        // Hash the PC and global history to get the PHT index
        int index = hash(predict_pc, global_history);
        // Predict taken if the counter is in the taken state (11 or 10)
        predict_taken = (pht[index][1]);
        // Output the current global history register value
        predict_history = global_history;
    end
    else begin
        predict_taken = 1'b0;
        predict_history = 7'b0000000;
    end
end

endmodule
