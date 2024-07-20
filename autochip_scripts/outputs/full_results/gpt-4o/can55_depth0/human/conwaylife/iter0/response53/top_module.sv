module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	// Function to count the number of alive neighbors
	function [3:0] count_neighbors;
		input [255:0] grid;
		input [3:0] x, y;
		integer dx, dy;
		begin
			count_neighbors = 0;
			for (dx = -1; dx <= 1; dx = dx + 1)
				for (dy = -1; dy <= 1; dy = dy + 1)
					if (dx != 0 || dy != 0)
						count_neighbors = count_neighbors + grid[((((y+dy+16)%16)<<4) + ((x+dx+16)%16))];
		end
	endfunction

	// Internal register to hold next state
	reg [255:0] next_q;

	integer i;
	integer j;
	integer n;

	// Always block to update the grid 'q' at each clock cycle
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (j = 0; j < 16; j = j + 1) begin
				for (i = 0; i < 16; i = i + 1) begin
					n = count_neighbors(q, i, j);
					if (n == 3) begin
						next_q[j*16 + i] = 1;
					end else if (n == 2) begin
						next_q[j*16 + i] = q[j*16 + i];
					end else begin
						next_q[j*16 + i] = 0;
					end
				end
			end
			q <= next_q;
		end
	end

endmodule
