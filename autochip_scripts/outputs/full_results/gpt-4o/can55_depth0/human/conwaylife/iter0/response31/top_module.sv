module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	wire [15:0] grid [15:0];
	reg [15:0] next_grid [15:0];
	integer i, j;

	// Unpack the 256-bit input into a 16x16 grid
	genvar x, y;
	generate
		for (x = 0; x < 16; x = x + 1) begin : unpack
			for (y = 0; y < 16; y = y + 1) begin : unpack_inner
				assign grid[x][y] = q[x * 16 + y];
			end
		end
	endgenerate

	always @(*) begin
		// Initialize next state grid to zero
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				next_grid[i][j] = 0;
			end
		end
		
		// Compute next state of the grid
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				integer neighbours;
				neighbours = 0;
				
				// Check all 8 neighbours with wrapping
				neighbours = grid[(i + 1) % 16][j] + grid[(i + 15) % 16][j] +
				             grid[i][(j + 1) % 16] + grid[i][(j + 15) % 16] +
				             grid[(i + 1) % 16][(j + 1) % 16] + grid[(i + 15) % 16][(j + 15) % 16] +
				             grid[(i + 1) % 16][(j + 15) % 16] + grid[(i + 15) % 16][(j + 1) % 16];
				
				// Apply the rules
				if (neighbours == 3) begin
					next_grid[i][j] = 1;
				end else if (neighbours == 2) begin
					next_grid[i][j] = grid[i][j];
				end else begin
					next_grid[i][j] = 0;
				end
			end
		end
	end
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Flatten next_grid back to the 256-bit output
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					q[i * 16 + j] <= next_grid[i][j];
				end
			end
		end
	end
endmodule
