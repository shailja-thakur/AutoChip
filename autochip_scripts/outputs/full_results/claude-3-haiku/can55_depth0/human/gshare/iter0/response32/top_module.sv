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

    // 128-entry pattern history table (PHT)
    reg [1:0] pht [127:0];

    // Hash function to generate PHT index
    function [6:0] hash_index;
        input [6:0] pc;
        input [6:0] history;
        begin
            hash_index = pc ^ history;
        end
    endfunction

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            predict_taken = pht[hash_index(predict_pc, global_history)][1];
            predict_history = global_history;
        end
        else begin
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
        end
        else begin
            if (train_valid) begin
                // Update PHT
                pht[hash_index(train_pc, train_history)] <= (train_taken) ? pht[hash_index(train_pc, train_history)] + 2'b01 : pht[hash_index(train_pc, train_history)] - 2'b01;

                // Recover global history on misprediction
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
                else begin
                    global_history <= (train_taken) ? {global_history[5:0], 1'b1} : {global_history[5:0], 1'b0};
                end
            end
        end
    end

endmodule
