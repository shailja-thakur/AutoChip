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

// 7-bit PC and 7-bit global history
// Hash them using XOR to get a 7-bit index
wire [6:0] index = predict_pc ^ predict_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Initialize PHT to weakly not taken
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01;
        end
        // Initialize global history to 0
        predict_history <= 7'b0;
    end
    else begin
        // Prediction
        if (predict_valid) begin
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= {predict_history[5:0], predict_taken};
        end

        // Training
        if (train_valid) begin
            // Update PHT
            pht[index] <= (train_taken) ? (pht[index] == 2'b11 ? 2'b11 : pht[index] + 2'b01) : (pht[index] == 2'b00 ? 2'b00 : pht[index] - 2'b01);

            // Update global history
            if (train_mispredicted) begin
                predict_history <= train_history;
            end
            else begin
                predict_history <= {predict_history[5:0], train_taken};
            end
        end
    end
end

endmodule
