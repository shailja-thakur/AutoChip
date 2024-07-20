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

// 7-bit PC and 7-bit global history
reg [6:0] global_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht[127:0];

// Hash PC and global history to get 7-bit index into PHT
function [6:0] hash_index;
    input [6:0] pc;
    input [6:0] history;
    begin
        hash_index = pc ^ history;
    end
endfunction

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b10; // Initialize PHT to weakly taken
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            int index = hash_index(predict_pc, global_history);

            // Make prediction based on PHT counter value
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= global_history;

            // Update global history register
            global_history <= {global_history[5:0], predict_taken};
        end

        // Training logic
        if (train_valid) begin
            // Hash PC and global history to get PHT index
            int index = hash_index(train_pc, train_history);

            // Update PHT counter based on actual branch outcome
            if (train_taken) begin
                if (pht[index] != 2'b11) begin
                    pht[index] <= pht[index] + 1'b1;
                end
            end
            else begin
                if (pht[index] != 2'b00) begin
                    pht[index] <= pht[index] - 1'b1;
                end
            end

            // If mispredicted, recover global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
