module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= next_q;
	end

	// Iterate over each cell in the grid
	// Note: This approach assumes the input grid is in toroid representation
	// If not, additional logic needs to be added to handle boundary conditions

	genvar i, j;
	generate
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				assign next_q[i*16 + j] = compute_cell_state(i, j);
			end
		end
	endgenerate

	function compute_cell_state(row, col);
		reg [3:0] num_neighbors;
		integer ne, nw, n, ne, sw, s, se, e, w;

		// Wrap around indices for toroid representation
		ne = (row == 0) ? 15 : row - 1;
		nw = (row == 0) ? 15 : row - 1;
		n = row;
		sw = (row == 15) ? 0 : row + 1;
		se = (row == 15) ? 0 : row + 1;
		s = row;
		e = (col == 15) ? 0 : col + 1;
		w = (col == 0) ? 15 : col - 1;

		num_neighbors = q[ne*16 + e] + q[n*16 + e] + q[ne*16 + col] + q[sw*16 + e] + q[sw*16 + w] + q[s*16 + w] + q[se*16 + w] + q[se*16 + col];
		
		// Compute the next state of the cell based on the number of neighbors
		case (num_neighbors)
			2: compute_cell_state = q[row*16 + col];
			3: compute_cell_state = 1;
			default: compute_cell_state = 0;
		endcase
	endfunction

endmodule
