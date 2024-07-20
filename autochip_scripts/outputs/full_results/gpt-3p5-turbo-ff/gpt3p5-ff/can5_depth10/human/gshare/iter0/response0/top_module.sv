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

	reg [6:0] history_reg;
	reg [6:0] index;
	reg [6:0] pht_entry;
	reg [1:0] counters [0:127];
	reg predict_taken;
	reg [1:0] predict_counter;
	reg [1:0] train_counter;
	reg [6:0] train_index;

	always@(posedge clk or posedge areset) begin
		if (areset) begin
			history_reg <= 0;
			pht_entry <= 0;
			counters[0] <= 0;
		  counters[1] <= 0;
	  	counters[2] <= 0;
	  	counters[3] <= 0;
	  	counters[4] <= 0;
	  	counters[5] <= 0;
	  	counters[6] <= 0;
    	...
    	...
		end else begin
			history_reg <= {history_reg[5:0], predict_taken};
		end
	end

	always@(posedge clk) begin
		if (predict_valid) begin
			index = predict_pc ^ history_reg;
			pht_entry = counters[index];
			predict_taken = (pht_entry > 1) ? 1 : 0;
			predict_counter = counters[index];
			predict_history = history_reg;
		end

		if (train_valid) begin
			train_index = train_pc ^ train_history;
			train_counter = counters[train_index];
			counters[train_index] = (train_taken) ? (train_counter < 3) ? train_counter + 1 : train_counter : (train_counter > 0) ? train_counter - 1 : train_counter;
		end
	end

endmodule
