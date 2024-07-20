module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			reg [255:0] next_q;
			integer i, j;

			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					integer row, col;
					integer alive_neighbors;

					// Count the alive neighbors
					alive_neighbors = 0;
					for (row = -1; row <= 1; row = row + 1) begin
						for (col = -1; col <= 1; col = col + 1) begin
							if (row != 0 || col != 0) begin
								integer ni, nj;
								ni = (i + row + 16) % 16;
								nj = (j + col + 16) % 16;
								alive_neighbors = alive_neighbors + q[ni * 16 + nj];
							end
						end
					end

					// Determine the next state of the cell
					if (alive_neighbors == 3 || (alive_neighbors == 2 && q[i * 16 + j] == 1)) begin
						next_q[i * 16 + j] = 1;
					end else begin
						next_q[i * 16 + j] = 0;
					end
				end
			end

			q <= next_q;
		end
	end

endmodule
