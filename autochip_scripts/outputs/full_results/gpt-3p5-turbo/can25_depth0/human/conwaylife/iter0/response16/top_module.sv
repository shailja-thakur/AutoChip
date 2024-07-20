module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	// Internal wires
	wire [255:0] next_state;
	
	// Register for loading initial state
	reg [255:0] initial_state;
	
	// Counter for counting the number of neighbors
	reg [7:0] neighbor_count [255:0];
	
	// Generate clock edge for loading initial state
	always @(posedge clk) begin
		if (load)
			initial_state <= data;
	end
	
	// Generate next state based on current state and neighbor count
	always_comb begin
		for (int row = 0; row < 16; row = row + 1) begin
			for (int col = 0; col < 16; col = col + 1) begin
				int index = row * 16 + col;
				
				// Calculate the number of neighbors for the current cell
				neighbor_count[index] = q[(row-1)*16 + col] + q[(row+1)*16 + col] + q[row*16 + (col-1)] + q[row*16 + (col+1)] + q[(row-1)*16 + (col-1)] + q[(row-1)*16 + (col+1)] + q[(row+1)*16 + (col-1)] + q[(row+1)*16 + (col+1)];
				
				// Determine the next state based on the number of neighbors
				if (neighbor_count[index] == 3)
					next_state[index] = 1;
				else if (neighbor_count[index] == 2)
					next_state[index] = q[index];
				else
					next_state[index] = 0;
			end
		end
	end
	
	// Update q to the next state every clock cycle
	always @(posedge clk) begin
		q <= next_state;
	end
	
endmodule
