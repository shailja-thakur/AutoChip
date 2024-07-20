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

	// Grid cell indices
	reg [3:0] x;
	reg [3:0] y;

	// Cell and neighbor counts
	reg [3:0] cell_count;
	reg [3:0] neighbor_count;

	// Count the number of neighbors for each cell
	always @* begin
		// Reset counts
		for (x = 0; x < 16; x = x + 1) begin
			for (y = 0; y < 16; y = y + 1) begin
				neighbor_count[x*16+y] = 0;
			end
		end

		// Count neighbors for each cell
		for (x = 0; x < 16; x = x + 1) begin
			for (y = 0; y < 16; y = y + 1) begin
				// Check neighbors using modulo arithmetic to wrap around the torus
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[((x+15)%16)*16+((y+15)%16)];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[((x+15)%16)*16+y];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[((x+15)%16)*16+((y+1)%16)];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[x*16+((y+15)%16)];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[x*16+((y+1)%16)];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[((x+1)%16)*16+((y+15)%16)];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[((x+1)%16)*16+y];
				neighbor_count[x*16+y] = neighbor_count[x*16+y] + q[((x+1)%16)*16+((y+1)%16)];
			end
		end
	end

	// Update the game state based on the neighbor counts
	always @* begin
		for (x = 0; x < 16; x = x + 1) begin
			for (y = 0; y < 16; y = y + 1) begin
				cell_count[x*16+y] = neighbor_count[x*16+y];
			end
		end

		// Apply the game rules
		for (x = 0; x < 16; x = x + 1) begin
			for (y = 0; y < 16; y = y + 1) begin
				if (cell_count[x*16+y] <= 1)
					next_q[x*16+y] = 0;
				else if (cell_count[x*16+y] == 2)
					next_q[x*16+y] = q[x*16+y];
				else if (cell_count[x*16+y] == 3)
					next_q[x*16+y] = 1;
				else
					next_q[x*16+y] = 0;
			end
		end
	end

	// Assign next_q to q at the end of each clock cycle
	always @(posedge clk) begin
		q <= next_q;
	end

endmodule
