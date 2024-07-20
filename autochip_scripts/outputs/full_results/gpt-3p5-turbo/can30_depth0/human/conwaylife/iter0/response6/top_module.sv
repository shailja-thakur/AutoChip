module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	// Declare internal wires and registers
	reg [255:0] next_q;
	reg [255:0] row_above, row_below;
	reg [15:0] left_neighbor, right_neighbor;
	reg [15:0] alive_neighbors;

	// Logic to calculate cell state
	always @(*) begin
		// Iterate over each cell in the grid
		for (int i = 0; i < 256; i = i + 1) begin
			// Extract row, column indices from cell index
			int row = i / 16;
			int col = i % 16;

			// Calculate indices of neighboring cells
			int row_above_index = (row > 0) ? ((row-1) * 16 + col) : ((15 * 16) + col);
			int row_below_index = (row < 15) ? ((row+1) * 16 + col) : (col);
			int left_neighbor_index = (col > 0) ? (row * 16 + (col-1)) : (row * 16 + 15);
			int right_neighbor_index = (col < 15) ? (row * 16 + (col+1)) : (row * 16);

			// Get values of neighboring cells
			row_above = q[row_above_index];
			row_below = q[row_below_index];
			left_neighbor = q[left_neighbor_index];
			right_neighbor = q[right_neighbor_index];

			// Calculate number of alive neighbors
			alive_neighbors = row_above[col] + row_below[col] + left_neighbor + right_neighbor;

			// Apply game rules to update cell state
			if (load) begin
				// Load initial state
				next_q[i] = data[i];
			end else begin
				// Update state based on game rules
				case (alive_neighbors)
					2: next_q[i] = q[i];
					3: next_q[i] = 1;
					default: next_q[i] = 0;
				endcase
			end
		end
	end

	// Assign next_q to q at the rising edge of the clock
	always @(posedge clk) begin
		q <= next_q;
	end
endmodule
