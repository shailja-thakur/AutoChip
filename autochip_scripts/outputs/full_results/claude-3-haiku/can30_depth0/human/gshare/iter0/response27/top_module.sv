module gshare_predictor (
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

    // 7-bit global history register
    reg [6:0] global_history;

    // 128-entry pattern history table (PHT) of 2-bit saturating counters
    reg [1:0] pht [127:0];

    // Hash function to get PHT index from PC and global history
    function [6:0] hash(
        input [6:0] pc,
        input [6:0] history
    );
        hash = pc ^ history;
    endfunction

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            // Hash PC and global history to get PHT index
            localparam PHT_INDEX = hash(predict_pc, global_history);
            // Make prediction based on saturating counter value
            predict_taken = (pht[PHT_INDEX] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b10;
            end
        end else begin
            if (train_valid) begin
                // Hash PC and global history to get PHT index
                localparam PHT_INDEX = hash(train_pc, train_history);
                // Update PHT based on actual branch outcome
                if (train_taken) begin
                    if (pht[PHT_INDEX] != 2'b11) begin
                        pht[PHT_INDEX] <= pht[PHT_INDEX] + 1'b1;
                    end
                end else begin
                    if (pht[PHT_INDEX] != 2'b00) begin
                        pht[PHT_INDEX] <= pht[PHT_INDEX] - 1'b1;
                    end
                end
                // Update global history register
                global_history <= (global_history << 1) | train_taken;
                // If misprediction, recover global history register
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end
        end
    end

endmodule
