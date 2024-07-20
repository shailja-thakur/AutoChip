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
parameter HISTORY_SIZE = 7;

reg [1:0] pht[PHT_SIZE-1:0];
reg [HISTORY_SIZE-1:0] global_history;

wire [6:0] pht_index;
assign pht_index = predict_pc ^ global_history;

// Prediction logic
always @(*) begin
    if (predict_valid) begin
        predict_taken = pht[pht_index][1];
        predict_history = global_history;
    end
    else begin
        predict_taken = 1'b0;
        predict_history = 7'b0;
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        global_history <= 7'b0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] <= 2'b10;
        end
    end
    else begin
        if (train_valid) begin
            // Update PHT
            if (train_taken) begin
                pht[train_pc ^ train_history][1:0] <= (pht[train_pc ^ train_history][1:0] == 2'b00) ? 2'b01 : (pht[train_pc ^ train_history][1:0] + 1);
            end
            else begin
                pht[train_pc ^ train_history][1:0] <= (pht[train_pc ^ train_history][1:0] == 2'b11) ? 2'b10 : (pht[train_pc ^ train_history][1:0] - 1);
            end

            // Update global history
            if (train_mispredicted) begin
                global_history <= train_history;
            end
            else begin
                global_history <= {global_history[HISTORY_SIZE-2:0], train_taken};
            end
        end
    end
end

endmodule
