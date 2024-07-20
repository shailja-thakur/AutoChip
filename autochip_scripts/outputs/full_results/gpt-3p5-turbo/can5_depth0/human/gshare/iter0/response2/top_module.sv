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

reg [6:0] prediction_pc_reg;
reg [6:0] prediction_history_reg;
reg predict_taken_reg;
reg [6:0] train_pc_reg;
reg [6:0] train_history_reg;
reg train_taken_reg;
reg train_mispredicted_reg;
reg [2:0] pattern_history_table [0:127];

assign predict_taken = predict_taken_reg;
assign predict_history = prediction_history_reg;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        prediction_pc_reg <= 0;
        prediction_history_reg <= 0;
        predict_taken_reg <= 0;
    end else if (predict_valid) begin
        prediction_pc_reg <= predict_pc;
        prediction_history_reg <= pattern_history_table[predict_pc];
        predict_taken_reg <= prediction_history_reg[1];
    end
end

always @(posedge clk or posedge areset) begin
    if (areset) begin
        train_pc_reg <= 0;
        train_history_reg <= 0;
        train_taken_reg <= 0;
        train_mispredicted_reg <= 0;
    end else if (train_valid) begin
        train_pc_reg <= train_pc;
        train_history_reg <= pattern_history_table[train_pc];
        train_taken_reg <= train_taken;
        train_mispredicted_reg <= train_mispredicted;
    end
end

always @(posedge clk) begin
    if (train_valid && train_mispredicted_reg) begin
        pattern_history_table[train_pc_reg] <= train_taken_reg ? 
                                                   pattern_history_table[train_pc_reg] + 1 : 
                                                   pattern_history_table[train_pc_reg] - 1;
        pattern_history_table[prediction_pc_reg] <= {pattern_history_table[prediction_pc_reg][5:0], train_taken_reg};
    end
end

endmodule
