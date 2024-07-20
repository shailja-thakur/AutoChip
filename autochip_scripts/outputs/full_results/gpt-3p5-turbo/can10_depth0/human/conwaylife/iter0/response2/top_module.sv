module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] temp_q; // Temporary variable to store the updated game state

	// Assign initial state of the game
	initial 
	begin
		temp_q = 0;
	end

	always @(posedge clk)
	begin
		if (load)
			q <= data; // Load initial state

		else
		begin
			// Iterate over each cell in the grid
			for (int i = 0; i < 256; i = i + 16)
			begin
				for (int j = 0; j < 16; j = j + 1)
				begin
					int count = 0; // Counter for the number of neighbors

					// Check the state of each neighbor and update the counter
					if (q[(i + (j + 15)%16)] == 1) // Left neighbor
						count = count + 1;

					if (q[(i + (j + 1)%16)] == 1) // Right neighbor
						count = count + 1;

					if (q[((i + 15)%256) + j] == 1) // Top neighbor
						count = count + 1;

					if (q[((i + 16)%256) + j] == 1) // Bottom neighbor
						count = count + 1;

					if (q[((i + 15)%256) + (j + 15)%16] == 1) // Top-left neighbor
						count = count + 1;

					if (q[((i + 15)%256) + (j + 1)%16] == 1) // Top-right neighbor
						count = count + 1;

					if (q[((i + 17)%256) + (j + 15)%16] == 1) // Bottom-left neighbor
						count = count + 1;

					if (q[((i + 17)%256) + (j + 1)%16] == 1) // Bottom-right neighbor
						count = count + 1;

					// Update the state of the current cell based on the number of neighbors
					if (count == 2)
						temp_q[i + j] <= q[i + j];

					else if (count == 3)
						temp_q[i + j] <= 1;

					else
						temp_q[i + j] <= 0;
				end
			end

			q <= temp_q; // Update the game state with the new values
		end
	end

endmodule
