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

// 7-bit PC and 7-bit global history, hashed using XOR into a 7-bit index
wire [6:0] index = predict_pc ^ predict_history;

// 128-entry table of 2-bit saturating counters
reg [1:0] pht [127:0];

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset all PHT entries to weakly not-taken (01)
        for (int i = 0; i < 128; i = i + 1) begin
            pht[i] <= 2'b01;
        end
        predict_history <= 7'b0;
    end
    else begin
        // Prediction logic
        if (predict_valid) begin
            predict_taken <= (pht[index] >= 2'b10);
            predict_history <= {predict_history[5:0], predict_taken};
        end

        // Training logic
        if (train_valid) begin
            // Update the PHT entry
            pht[train_pc ^ train_history] <= (train_taken) ? (pht[train_pc ^ train_history] + 2'b01) : (pht[train_pc ^ train_history] - 2'b01);

            // Recover the branch history register on a misprediction
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
