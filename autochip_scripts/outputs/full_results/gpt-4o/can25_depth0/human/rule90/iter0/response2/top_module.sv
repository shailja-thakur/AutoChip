module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Define a temporary register to hold the next state
			reg [511:0] next_q;
			integer i;
			
			// Calculate the next state based on Rule 90
			for (i = 0; i < 512; i = i + 1) begin
				if (i == 0) begin
					// Boundary case for the leftmost cell
					next_q[i] = 0 ^ q[i+1];
				end else if (i == 511) begin
					// Boundary case for the rightmost cell
					next_q[i] = q[i-1] ^ 0;
				end else begin
					// General case for all other cells
					next_q[i] = q[i-1] ^ q[i+1];
				end
			end
			
			// Update q with the new state
			q <= next_q;
		end
	end
endmodule
