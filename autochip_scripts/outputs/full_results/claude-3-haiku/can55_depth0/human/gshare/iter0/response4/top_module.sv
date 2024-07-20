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

// 7-bit PC and 7-bit global history, hashed using XOR to a 7-bit index
wire [6:0] index = predict_pc ^ predict_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Initialize the PHT to the weakly not-taken state
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01;
        end
        predict_history <= 7'b0;
    end
    else begin
        // Training
        if (train_valid) begin
            // Update the PHT based on the actual branch outcome
            if (train_taken) begin
                if (pht[train_pc ^ train_history] != 2'b11)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] + 1'b1;
            end
            else begin
                if (pht[train_pc ^ train_history] != 2'b00)
                    pht[train_pc ^ train_history] <= pht[train_pc ^ train_history] - 1'b1;
            end

            // Recover the branch history register if the branch was mispredicted
            if (train_mispredicted)
                predict_history <= train_history;
            else
                predict_history <= (predict_history << 1) | train_taken;
        end
        // Prediction
        else if (predict_valid) begin
            // Predict the branch direction based on the PHT
            predict_taken <= (pht[predict_pc ^ predict_history] >= 2'b10);

            // Update the branch history register
            predict_history <= (predict_history << 1) | predict_taken;
        end
    end
end

endmodule
