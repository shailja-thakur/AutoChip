module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	// Create a register to store the next state of the game
	reg [255:0] next_q;
	
	// Define the number of rows and columns
	parameter ROWS = 16;
	parameter COLS = 16;
	
	// Define the number of neighbors
	parameter NEIGHBORS = 8;
	
	// Define the indices for the neighbors
	parameter [7:0] neighbor_indices [NEIGHBORS] = {8'b11111111, 8'b11111110, 8'b11111011, 8'b00000001, 8'b00001111, 8'b00000010, 8'b00000000, 8'b00001110};
	
	// Define the rules for cell state transitions
	always @(posedge clk) begin
		if (load) begin
			// Load the initial state of the game
			q <= data;
		end
		else begin
			// Compute the next state of the game
			for (integer i = 0; i < ROWS; i = i + 1) begin
				for (integer j = 0; j < COLS; j = j + 1) begin
					// Count the number of neighbors
					integer count = 0;
					for (integer k = 0; k < NEIGHBORS; k = k + 1) begin
						count = count + q[((i + neighbor_indices[k]) % ROWS)*COLS + ((j + neighbor_indices[k]) % COLS)];
					end
					
					// Apply the rules for cell state transition
					if (count == 2) begin
						next_q[i*COLS + j] <= q[i*COLS + j];
					end
					else if (count == 3) begin
						next_q[i*COLS + j] <= 1;
					end
					else begin
						next_q[i*COLS + j] <= 0;
					end
				end
			end
			
			// Update the state of the game
			q <= next_q;
		end
	end
endmodule
