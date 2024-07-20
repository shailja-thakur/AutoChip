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

parameter PHT_SIZE = 128;
reg [1:0] pht[PHT_SIZE-1:0];
reg [6:0] global_history;

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        predict_taken = pht[predict_pc ^ global_history][1];
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
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b10;
        end
    end else begin
        if (train_valid) begin
            // Update PHT
            if (train_taken)
                pht[train_pc ^ train_history][1:0] <= pht[train_pc ^ train_history][1:0] + 1;
            else
                pht[train_pc ^ train_history][1:0] <= pht[train_pc ^ train_history][1:0] - 1;

            // Update global history
            if (train_mispredicted)
                global_history <= train_history;
            else
                global_history <= (global_history << 1) | train_taken;
        end
    end
end

endmodule
