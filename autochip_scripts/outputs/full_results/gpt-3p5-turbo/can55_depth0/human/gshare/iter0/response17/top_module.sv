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

	reg [6:0] pht_index;
	reg [6:0] global_history;
	reg [6:0] predict_next_history;

	reg [1:0] pht [0:127]; // 128-entry pattern history table

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			pht <= 2'd3; // initialize all entries to strongly taken (3)
			global_history <= 7'd0;
		end else begin
			if (predict_valid) begin
				pht_index <= predict_pc ^ global_history; // hash pc and global history into a 7-bit index
				
				predict_taken <= (pht[pht_index] == 2'd3 || pht[pht_index] == 2'd2); // predict taken if strongly taken or weakly taken
				predict_next_history <= {global_history[5:0], predict_taken}; // shift in predict_taken to next history
				
				predict_history <= predict_next_history; // output the history used for the prediction
			end
			
			if (train_valid) begin
				pht_index <= train_pc ^ train_history; // hash pc and train history into a 7-bit index
				
				if (train_mispredicted) begin
					pht[pht_index] <= (pht[pht_index] == 2'd0 || pht[pht_index] == 2'd1) ? 2'd0 : 2'd1; // recover the pht entry to weakly not taken or strongly not taken
					global_history <= {train_history[5:0], train_taken}; // update the global history to the state after the mispredicting branch completes execution
				end else begin
					pht[pht_index] <= (pht[pht_index] == 2'd3 || pht[pht_index] == 2'd2) ? 2'd3 : 2'd2; // update pht entry to weakly taken or strongly taken
					global_history <= {train_history[5:0], train_taken}; // update the global history with the actual branch outcome
				end
			end
		end
	end

endmodule
