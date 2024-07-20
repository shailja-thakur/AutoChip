module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		// Handle the load condition
		if (load) begin
			q <= data;
		end
		else begin
			integer i;
			// Temporary array to store next state
			reg [511:0] next_q;
			for (i = 0; i < 512; i = i + 1) begin
				if (i == 0) begin
					// First cell (has only right neighbor)
					next_q[i] = q[1] ^ 1'b0;
				end
				else if (i == 511) begin
					// Last cell (has only left neighbor)
					next_q[i] = q[510] ^ 1'b0;
				end
				else begin
					// All other cells (has both left and right neighbors)
					next_q[i] = q[i-1] ^ q[i+1];
				end
			end
			// Update q with the next state
			q <= next_q;
		end
	end
endmodule
