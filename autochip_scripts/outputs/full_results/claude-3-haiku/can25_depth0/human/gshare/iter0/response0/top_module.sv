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

// Hash function to get index into PHT
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
        for (int i = 0; i < 128; i++) begin
            pht[i] <= 2'b10; // Initialize PHT to weakly not taken
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            int index = hash_index(predict_pc, global_history);

            // Predict branch direction based on PHT
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= global_history;

            // Update global history register
            global_history <= (predict_taken) ? {global_history[5:0], 1'b1} : {global_history[5:0], 1'b0};
        end

        // Training logic
        if (train_valid) begin
            // Hash PC and global history to get PHT index
            int index = hash_index(train_pc, train_history);

            // Update PHT based on actual branch outcome
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b01 : (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1;
            end
            else begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b10 : (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1;
            end

            // If mispredicted, recover global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
