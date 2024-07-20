module top_module(
    input clk,
    input areset,

    input predict_valid,
    input [6:0] predict_pc,
    output predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);

// Define parameters
parameter INDEX_BITS = 7;
parameter INDEX_SIZE = 2 ** INDEX_BITS;

parameter STATE_BITS = 2;
parameter PHT_SIZE = 128;

// Define registers
reg [INDEX_BITS-1:0] index_reg;
reg [PHT_SIZE-1:0] pht_reg;
reg [STATE_BITS-1:0] history_reg;

// Define wires
wire [1:0] prediction;

// Prediction logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        index_reg <= 0;
    end else if (predict_valid) begin
        index_reg <= predict_pc ^ history_reg;
        prediction <= pht_reg[index_reg];
    end
end

// Training logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        pht_reg <= 0;
        history_reg <= 0;
    end else if (train_valid) begin
        pht_reg[train_pc] <= train_taken ? pht_reg[train_pc] + 1 : pht_reg[train_pc] - 1;
        if (train_mispredicted) begin
            history_reg <= train_history;
        end
    end
end

// Output assignment
assign predict_taken = prediction[1];
assign predict_history = history_reg;

endmodule
