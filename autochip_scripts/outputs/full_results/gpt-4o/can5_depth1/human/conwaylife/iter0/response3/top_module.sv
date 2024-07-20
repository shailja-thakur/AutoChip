module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	integer i, j;

	// Function to count the number of alive (1) neighbors
	function integer count_neighbors;
		input [255:0] grid;
		input integer x, y;
		integer xi, yi, count;
		begin
			count = 0;
			for (xi = -1; xi <= 1; xi = xi + 1) begin
				for (yi = -1; yi <= 1; yi = yi + 1) begin
					if (xi != 0 || yi != 0) begin
						if (grid[(((x + xi + 16) % 16) * 16) + ((y + yi + 16) % 16)]) begin
							count = count + 1;
						end
					end
				end
			end
			count_neighbors = count;
		end
	endfunction
	
	always @(posedge clk) begin
		if (load)
			q <= data;
		else begin
			reg [255:0] next_state;
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					integer neighbor_count = count_neighbors(q, i, j);
					integer idx = i * 16 + j;
					if (neighbor_count < 2 || neighbor_count > 3)
						next_state[idx] = 0;
					else if (neighbor_count == 3)
						next_state[idx] = 1;
					else
						next_state[idx] = q[idx];
				end
			end
			q <= next_state;
		end
	end
endmodule
