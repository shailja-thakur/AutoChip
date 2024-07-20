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

    // Hash function to get PHT index
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
                pht[i] <= 2'b01; // Initialize PHT to weakly not-taken
            end
        end
        else begin
            // Prediction logic
            if (predict_valid) begin
                // Hash PC and global history to get PHT index
                integer pht_index = hash_index(predict_pc, global_history);

                // Update branch history register
                global_history <= {global_history[5:0], pht[pht_index][0]};

                // Produce branch prediction
                predict_taken <= pht[pht_index][1];
                predict_history <= global_history;
            end

            // Training logic
            if (train_valid) begin
                // Hash PC and global history to get PHT index
                integer pht_index = hash_index(train_pc, train_history);

                // Update pattern history table
                if (train_taken) begin
                    pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : pht[pht_index] + 1;
                end
                else begin
                    pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : pht[pht_index] - 1;
                end

                // Recover global history on misprediction
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

endmodule
