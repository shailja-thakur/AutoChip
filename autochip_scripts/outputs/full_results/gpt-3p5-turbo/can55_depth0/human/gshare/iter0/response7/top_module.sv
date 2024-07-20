module top_module(
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

// Parameters
parameter INDEX_BITS = 7;
parameter HISTORY_BITS = 7;
parameter PHT_SIZE = 128;
parameter COUNTER_BITS = 2;

// Internal signals and registers
reg [INDEX_BITS-1:0] index;
reg [COUNTER_BITS-1:0] pht[PHT_SIZE-1:0];
reg [HISTORY_BITS-1:0] history;

// Outputs
reg predict_taken_reg;
reg [HISTORY_BITS-1:0] predict_history_reg;

// Predict logic
always @(posedge clk) begin
    if (areset) begin
        predict_taken_reg <= 1'b0;
        predict_history_reg <= 0;
    end else if (predict_valid) begin
        index <= predict_pc ^ history;
        predict_taken_reg <= pht[index] > 1;
        predict_history_reg <= history;
    end
end

assign predict_taken = predict_taken_reg;
assign predict_history = predict_history_reg;

// Training logic
always @(posedge clk) begin
    if (areset) begin
        history <= 0;
    end else if (train_valid) begin
        reg [INDEX_BITS-1:0] train_index;
        train_index <= train_pc ^ train_history;
        if (train_mispredicted) begin
            pht[train_index] <= (pht[train_index] == 0) ? 0 : pht[train_index] - 1;
        end else if (train_taken) begin
            pht[train_index] <= (pht[train_index] == 3) ? 3 : pht[train_index] + 1;
        end
        history <= {history[HISTORY_BITS-2:0], train_taken};
    end
end

endmodule
