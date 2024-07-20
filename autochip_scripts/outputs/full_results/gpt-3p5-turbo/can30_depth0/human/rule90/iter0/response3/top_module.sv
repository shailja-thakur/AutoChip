module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);
  
	// Internal signal to store the next state of the cells
	reg [511:0] q_next;
	
	// Assign initial state to q and q_next
	initial begin
		q = 0;
		q_next = 0;
	end

	// Always block to update the state of the cells
	always @(posedge clk) begin
		if (load) begin
			// Load the initial state of the cells from data
			q <= data;
		end
		else begin
			// Calculate the next state of each cell
			for (int i = 0; i < 512; i = i + 1) begin
				// Calculate the indices of the neighbors
				int left_ndx = i - 1;
				int right_ndx = i + 1;

				// Check if out of bounds
				if (left_ndx < 0) left_ndx = 511;
				if (right_ndx == 512) right_ndx = 0;

				// Calculate the next state of the cell using Rule 90
				q_next[i] = q[left_ndx] ^ q[right_ndx];
			end

			// Update the current state of the cells with the next state
			q <= q_next;
		end
	end

endmodule
