module gshare_predictor (
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

    // Hash function to get the PHT index
    function [6:0] hash(input [6:0] pc, input [6:0] history);
        hash = pc ^ history;
    endfunction

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash the PC and global history to get the PHT index
            int pht_index = hash(predict_pc, global_history);

            // Make the prediction based on the PHT entry
            predict_taken = (pht[pht_index] >= 2);
            predict_history = global_history;
        end else begin
            predict_taken = 0;
            predict_history = 0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b10;
            end
        end else begin
            if (train_valid) begin
                // Hash the training PC and history to get the PHT index
                int pht_index = hash(train_pc, train_history);

                // Update the PHT entry based on the actual branch outcome
                if (train_taken) begin
                    pht[pht_index] <= (pht[pht_index] == 2'b11) ? 2'b11 : pht[pht_index] + 1;
                end else begin
                    pht[pht_index] <= (pht[pht_index] == 2'b00) ? 2'b00 : pht[pht_index] - 1;
                end

                // Update the global history register
                global_history <= (train_taken) ? (global_history << 1) | 1 : (global_history << 1);

                // If the branch was mispredicted, recover the global history register
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

endmodule
