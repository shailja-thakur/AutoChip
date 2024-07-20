module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	// Internal wire for storing the next state of the game
	wire [255:0] next_state;

	// Registers for the current state and the next state of the game
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= next_state;
		end
	end

	// Logic for computing the next state of the game
	// Loop over each cell in the grid
	genvar i;
	genvar j;
	for (i = 0; i < 16; i = i + 1) begin
		for (j = 0; j < 16; j = j + 1) begin
			// Calculate the indices of the neighboring cells
			// Take care of wrapping around the edges of the grid
			integer left = (j == 0) ? 15 : j - 1;
			integer right = (j == 15) ? 0 : j + 1;
			integer up = (i == 0) ? 15 : i - 1;
			integer down = (i == 15) ? 0 : i + 1;

			// Count the number of alive neighbors
			integer num_neighbors = q[up*16 + left] + q[up*16 + j] + q[up*16 + right] +
			                       q[i*16 + left] + q[i*16 + right] +
			                       q[down*16 + left] + q[down*16 + j] + q[down*16 + right];

			// Determine the next state of the cell based on the number of neighbors
			if (num_neighbors <= 1) begin
				next_state[i*16 + j] = 0;
			end else if (num_neighbors == 2 && q[i*16 + j] == 1) begin
				next_state[i*16 + j] = 1;
			end else if (num_neighbors == 3) begin
				next_state[i*16 + j] = 1;
			end else begin
				next_state[i*16 + j] = 0;
			end
		end
	end

endmodule
