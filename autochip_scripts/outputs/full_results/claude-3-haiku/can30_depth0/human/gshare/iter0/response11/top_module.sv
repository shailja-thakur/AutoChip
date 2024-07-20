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
    reg [6:0] global_history;

    // 128-entry table of two-bit saturating counters
    reg [1:0] pht[127:0];

    // Hash the PC and global history to get the PHT index
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
    end

    // Training logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i = i + 1) begin
                pht[i] <= 2'b10;
            end
        end
        else begin
            if (train_valid) begin
                // Update the PHT
                if (train_taken) begin
                    pht[hash_index(train_pc, train_history)][1] <= 1'b1;
                end
                else begin
                    pht[hash_index(train_pc, train_history)][1] <= 1'b0;
                end

                // Update the global history register
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
                else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end

endmodule
