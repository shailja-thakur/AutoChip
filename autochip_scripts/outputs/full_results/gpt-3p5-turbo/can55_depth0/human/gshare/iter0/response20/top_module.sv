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

    reg [127:0] pattern_history_table [0:127];
    reg [6:0] global_branch_history_reg;

    reg [6:0] predict_index;
    reg [1:0] predict_counter;
    reg predict_taken_reg;
    reg [6:0] predict_history_reg;

    reg [6:0] train_index;
    reg [1:0] train_counter;
    reg train_taken_reg;
    reg [6:0] train_history_reg;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_branch_history_reg <= 0;
            pattern_history_table <= 0;
        end else begin
            if (predict_valid) begin
                predict_index <= predict_pc ^ global_branch_history_reg;
                predict_counter <= pattern_history_table[predict_index];
                if (predict_counter[1]) begin
                    predict_taken_reg <= 1;
                end else begin
                    predict_taken_reg <= 0;
                end
                predict_history_reg <= global_branch_history_reg;
            end

            if (train_valid) begin
                train_index <= train_pc ^ train_history;
                train_counter <= pattern_history_table[train_index];
                if (train_taken) begin
                    train_taken_reg <= 1;
                end else begin
                    train_taken_reg <= 0;
                end
                train_history_reg <= train_history;
            end
        end
    end

    always @(posedge clk) begin
        if (predict_valid) begin
            predict_taken <= predict_taken_reg;
            predict_history <= predict_history_reg;
        end

        if (train_valid) begin
            if (train_mispredicted) begin
                pattern_history_table[train_index] <= train_counter - 1;
                global_branch_history_reg <= train_history_reg;
            end else begin
                pattern_history_table[train_index] <= train_counter + 1;
            end
        end
    end

endmodule
