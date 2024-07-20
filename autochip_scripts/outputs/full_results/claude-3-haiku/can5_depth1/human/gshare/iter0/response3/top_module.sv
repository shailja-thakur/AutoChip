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
localparam PHT_SIZE = 128;
localparam HISTORY_SIZE = 7;

// 2-bit saturating counters in the PHT
reg [1:0] pht [PHT_SIZE-1:0];

// Global branch history register
reg [HISTORY_SIZE-1:0] global_history;

// Hash function to get PHT index
function [6:0] hash_index(input [6:0] pc, input [6:0] history);
    assign hash_index = pc ^ history;
endfunction

initial begin
    global_history = 0;
    for (int i = 0; i < PHT_SIZE; i++) begin
        pht[i] = 2'b01; // Initialize PHT to weakly not taken
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b01;
        end
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            // Hash PC and history to get PHT index
            reg [6:0] index = hash_index(predict_pc, global_history);

            // Make prediction and output
            predict_taken <= pht[index][1];
            predict_history <= global_history;
        end

        // Training logic
        if (train_valid) begin
            // Hash PC and history to get PHT index
            reg [6:0] index = hash_index(train_pc, train_history);

            // Update PHT based on actual branch outcome
            if (train_taken) begin
                if (pht[index] != 2'b11)
                    pht[index] <= pht[index] + 1'b1;
            end
            else begin
                if (pht[index] != 2'b00)
                    pht[index] <= pht[index] - 1'b1;
            end

            // Update global history register
            if (train_mispredicted) begin
                // Recover global history to state after mispredicted branch
                global_history <= train_history;
            end
            else begin
                // Update global history with actual branch outcome
                global_history <= (global_history << 1) | train_taken;
            end
        end
    end
end

endmodule
