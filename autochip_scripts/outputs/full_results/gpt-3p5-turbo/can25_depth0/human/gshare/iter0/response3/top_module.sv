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
	parameter PC_WIDTH = 7;
	parameter GLOBAL_HISTORY_WIDTH = 7;
	parameter INDEX_WIDTH = 7;
	parameter COUNTER_WIDTH = 2;

	// Registers
	reg [GLOBAL_HISTORY_WIDTH-1:0] global_history;
	reg [INDEX_WIDTH-1:0] index;
	reg [COUNTER_WIDTH-1:0] pht[TABLE_SIZE-1:0];

	// Internal signals
	reg [COUNTER_WIDTH-1:0] predict_counter;
	reg predict_value;

	// Predict interface
	always @(predict_valid or predict_pc or global_history)
	begin
		if (areset)
		begin
			predict_taken <= 0;
			predict_history <= 0;
		end
		else
		begin
			index <= predict_pc ^ global_history;
			predict_counter <= pht[index];
			predict_value <= (predict_counter > 1);
			
			predict_taken <= predict_value;
			predict_history <= global_history;
		end
	end

	// Train interface
	always @(posedge clk or areset)
	begin
		if (areset)
		begin
			global_history <= 0;
		end
		else if (train_valid)
		begin
			index <= train_pc ^ train_history;
			predict_counter <= pht[index];
			
			global_history <= {global_history[GLOBAL_HISTORY_WIDTH-2:0], train_taken};
			
			if (train_mispredicted)
			begin
				pht[index] <= (predict_counter > 0) ? (predict_counter - 1) : 0;
			end
			else
			begin
				pht[index] <= (predict_counter < 3) ? (predict_counter + 1) : 3;
			end
		end
	end

endmodule
