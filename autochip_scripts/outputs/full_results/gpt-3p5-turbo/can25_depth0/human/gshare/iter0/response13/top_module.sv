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

// Constants
parameter TABLE_SIZE = 128;
parameter INDEX_BITS = 7;
parameter PC_BITS = 7;
parameter HISTORY_BITS = 7;
parameter COUNTER_SIZE = 2;

// Registers
reg [6:0] pc_reg;
reg [6:0] history_reg;
reg [INDEX_BITS-1:0] index_reg;
reg [COUNTER_SIZE-1:0] counter_reg[TABLE_SIZE-1:0];

// Outputs
wire predict_taken;
wire [HISTORY_BITS-1:0] predict_history;

// Predict branch direction
always @(posedge clk) begin
    if (areset) begin
        pc_reg <= 7'b0;
        history_reg <= 7'b0;
        index_reg <= 7'b0;
    end else begin
        pc_reg <= predict_pc;
        history_reg <= predict_history;
        index_reg <= {predict_pc[INDEX_BITS-1:0]} ^ {history_reg[INDEX_BITS-1:0]};
    end
end

// Train branch predictor
always @(posedge clk) begin
    if (areset) begin
        counter_reg <= 0;
    end else begin
        if (train_valid) begin
            counter_reg[train_pc] <= counter_reg[train_pc] + (train_taken ? 1 : -1);
        end
    end
end

// Prediction output
assign predict_taken = counter_reg[index_reg] >= 2'h2;
assign predict_history = history_reg;

endmodule
