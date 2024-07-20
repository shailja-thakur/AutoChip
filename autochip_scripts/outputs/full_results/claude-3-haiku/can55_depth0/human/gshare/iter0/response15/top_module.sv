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

// 7-bit global branch history register
reg [6:0] global_history;

// 128-entry pattern history table (PHT) of 2-bit saturating counters
reg [1:0] pht [127:0];

// Hash function to index into the PHT
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
        // Prediction
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            integer index = hash_index(predict_pc, global_history);

            // Predict branch direction based on PHT
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= global_history;

            // Update global history register with predicted branch direction
            global_history <= {global_history[5:0], predict_taken};
        end

        // Training
        if (train_valid) begin
            // Hash PC and training history to get PHT index
            integer index = hash_index(train_pc, train_history);

            // Update PHT based on actual branch outcome
            if (train_taken) begin
                pht[index] <= (pht[index] == 2'b00) ? 2'b01 : (pht[index] + 2'b01);
            end
            else begin
                pht[index] <= (pht[index] == 2'b11) ? 2'b10 : (pht[index] - 2'b01);
            end

            // If misprediction, update global history register to correct state
            if (train_mispredicted) begin
                global_history <= train_history;
            end
        end
    end
end

endmodule
