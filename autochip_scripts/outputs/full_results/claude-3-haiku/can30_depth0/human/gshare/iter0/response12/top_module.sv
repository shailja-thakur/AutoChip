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

    // 128-entry table of 2-bit saturating counters
    reg [1:0] pht [0:127];

    // Global branch history register
    reg [6:0] global_history;

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
            for (int i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b01;
            end
        end
        else begin
            // Update global history register
            if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
            else if (train_valid && train_mispredicted) begin
                global_history <= train_history;
            end

            // Train the PHT
            if (train_valid) begin
                pht[hash_index(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b00;
            end
        end
    end

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_taken <= (pht[hash_index(predict_pc, global_history)][1]) ? 1'b1 : 1'b0;
            predict_history <= global_history;
        end
        else begin
            predict_taken <= 1'b0;
            predict_history <= 7'b0;
        end
    end

endmodule
