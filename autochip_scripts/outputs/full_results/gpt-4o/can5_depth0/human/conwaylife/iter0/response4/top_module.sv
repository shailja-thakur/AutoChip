module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

    // Intermediate storage for the next state of the grid
	reg [255:0] next_q;

	// Function to count the number of live neighbors for a given cell
	function [3:0] count_neighbors;
		input [255:0] grid;
		input integer row, col;
		integer r, c;
		begin
			count_neighbors = 0;
			for (r = -1; r <= 1; r = r + 1) begin
				for (c = -1; c <= 1; c = c + 1) begin
					if (r != 0 || c != 0) begin
						if (grid[((row + r + 16) % 16) * 16 + ((col + c + 16) % 16)]) count_neighbors = count_neighbors + 1;
					end
				end
			end
		end
	endfunction

	// Logic to advance the game state by one timestep
	always @(*) begin
		integer i, j;
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				case (count_neighbors(q, i, j))
					4'b0000, 4'b0001: next_q[i*16 + j] = 0; // 0-1 neighbors: Become dead
					4'b0010: next_q[i*16 + j] = q[i*16 + j]; // 2 neighbors: Stay the same
					4'b0011: next_q[i*16 + j] = 1; // 3 neighbors: Become alive
					default: next_q[i*16 + j] = 0; // 4 or more neighbors: Become dead
				endcase
			end
		end
	end

	// Logic to update the game state on the clock edge
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= next_q;
		end
	end
endmodule
