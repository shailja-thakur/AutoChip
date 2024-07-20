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

// 7-bit Global History Register
reg [6:0] global_history;

// 128-entry Pattern History Table
reg [1:0] pht [127:0];

// Hash function to get the 7-bit index into the PHT
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
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Handle prediction requests
        if (predict_valid) begin
            // Compute the PHT index
            reg [6:0] index = hash_index(predict_pc, global_history);

            // Make the prediction
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= global_history;
        end

        // Handle training requests
        if (train_valid) begin
            // Compute the PHT index
            reg [6:0] index = hash_index(train_pc, train_history);

            // Update the PHT based on the actual branch outcome
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b11 : pht[index] + 1'b1;
            end
            else begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b00 : pht[index] - 1'b1;
            end

            // Update the global history register
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
