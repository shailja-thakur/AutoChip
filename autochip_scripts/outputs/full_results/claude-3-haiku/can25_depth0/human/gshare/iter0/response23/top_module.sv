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

    // 7-bit hash function using XOR
    function [6:0] hash(input [6:0] a, input [6:0] b);
        hash = a ^ b;
    endfunction

    // 128-entry PHT of 2-bit saturating counters
    reg [1:0] pht[127:0];

    // Global branch history register
    reg [6:0] global_history;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                pht[i] <= 2'b01;
            end
        end
        else begin
            // Prediction
            if (predict_valid) begin
                predict_taken <= (pht[hash(predict_pc, global_history)] >= 2'b10);
                predict_history <= global_history;
            end

            // Training
            if (train_valid) begin
                // Update PHT
                pht[hash(train_pc, train_history)] <= (train_taken) ? 2'b11 : 2'b00;

                // Update global history
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
