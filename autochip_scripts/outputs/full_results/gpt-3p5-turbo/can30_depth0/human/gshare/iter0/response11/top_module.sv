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
parameter INDEX_SIZE = 7;
parameter TABLE_SIZE = 128;
parameter HISTORY_SIZE = 7;

// Registers
reg [HISTORY_SIZE-1:0] branch_history_reg;
reg [HISTORY_SIZE-1:0] branch_history_train_reg;
reg [INDEX_SIZE-1:0] index;

// Pattern History Table
reg [1:0] pattern_history_table [TABLE_SIZE-1:0];

// Assign outputs
assign predict_taken = pattern_history_table[index] >= 2;
assign predict_history = branch_history_reg;

// Predict state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_reg <= 0;
    end else if (predict_valid) begin
        branch_history_reg <= {branch_history_reg[HISTORY_SIZE-2:0], predict_taken};
    end
end

// Train state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        branch_history_train_reg <= 0;
    end else if (train_valid) begin
        branch_history_train_reg <= {branch_history_train_reg[HISTORY_SIZE-2:0], train_taken};
    end
end

// Pattern History Table update
always @(posedge clk or posedge areset) begin
    if (areset) begin
        for (integer i = 0; i < TABLE_SIZE; i = i + 1) begin
            pattern_history_table[i] <= 0;
        end
    end else if (train_valid) begin
        if (train_mispredicted) begin
            pattern_history_table[train_pc] <= $past(pattern_history_table[train_pc]) - $signed({2{branch_history_train_reg[0]}});
        end else begin
            pattern_history_table[train_pc] <= $past(pattern_history_table[train_pc]) + $signed({2{train_taken}});
        end
    end
end

// Index calculation
always @(posedge clk or posedge areset) begin
    if (areset) begin
        index <= 0;
    end else if (predict_valid || train_valid) begin
        index <= (predict_pc ^ branch_history_reg) & {INDEX_SIZE{1'b1}};
    end
end

endmodule
