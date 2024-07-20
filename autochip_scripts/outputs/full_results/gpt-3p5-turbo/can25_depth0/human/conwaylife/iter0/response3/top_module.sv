module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q; // Next state of the game

	always @(posedge clk) begin
		if (load) begin
			q <= data; // Load initial state
		end else begin
			// Calculate next state based on current state
			// Advance the game state by one timestep
			for (integer i = 0; i < 256; i = i + 1) begin
				integer row = i / 16;
				integer col = i % 16;
				integer neighbours = 0;

				// Count the number of alive neighbours
				neighbours = neighbours + q[((row-1+16)%16)*16 + ((col-1+16)%16)];
				neighbours = neighbours + q[((row-1+16)%16)*16 + col];
				neighbours = neighbours + q[((row-1+16)%16)*16 + ((col+1+16)%16)];
				neighbours = neighbours + q[row*16 + ((col-1+16)%16)];
				neighbours = neighbours + q[row*16 + ((col+1+16)%16)];
				neighbours = neighbours + q[((row+1+16)%16)*16 + ((col-1+16)%16)];
				neighbours = neighbours + q[((row+1+16)%16)*16 + col];
				neighbours = neighbours + q[((row+1+16)%16)*16 + ((col+1+16)%16)];

				// Apply the game rules to determine next state
				if (neighbours <= 1) begin
					next_q[i] = 0;
				end else if (neighbours == 2) begin
					next_q[i] = q[i];
				end else if (neighbours == 3) begin
					next_q[i] = 1;
				end else if (neighbours >= 4) begin
					next_q[i] = 0;
				end
			end

			q <= next_q; // Update the current state with the next state
		end
	end

endmodule
