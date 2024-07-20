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

    // 128-entry PHT (Pattern History Table) of 2-bit saturating counters
    reg [1:0] pht [127:0];

    // Hash function to get index into PHT
    function [6:0] hash_func;
        input [6:0] pc;
        input [6:0] history;
        begin
            hash_func = pc ^ history;
        end
    endfunction

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b10; // Initialize PHT to weakly not taken
            end
        end
        else begin
            // Prediction logic
            if (predict_valid) begin
                // Get PHT index and value
                integer pht_index = hash_func(predict_pc, global_history);
                predict_taken <= (pht[pht_index] >= 2'b10); // Predict taken if counter >= 2
                predict_history <= global_history;
            end

            // Training logic
            if (train_valid) begin
                // Update PHT entry
                integer pht_index = hash_func(train_pc, train_history);
                if (train_taken) begin
                    pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : (pht[pht_index] - 1'b1); // Decrement if not strongly not taken
                end
                else begin
                    pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : (pht[pht_index] + 1'b1); // Increment if not strongly taken
                end

                // Update global history register
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
