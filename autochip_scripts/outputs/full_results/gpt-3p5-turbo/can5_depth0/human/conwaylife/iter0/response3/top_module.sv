module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	reg [255:0] q_next;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= q_next;
		end
	end
	
	// Calculate the next state of the game
	always @* begin
		integer i, j;
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				// Count the number of alive neighbors
				integer alive_neighbors;
				alive_neighbors = q[((i+15)%16)*16 + (j+1)%16] + q[((i+15)%16)*16 + j] + q[((i+15)%16)*16 + (j+15)%16] + q[(i*16 + (j+1)%16)] + q[(i*16 + (j+15)%16)] + q[((i+1)%16)*16 + (j+1)%16] + q[((i+1)%16)*16 + j] + q[((i+1)%16)*16 + (j+15)%16];
				
				// Determine the new state based on the number of neighbors
				if (alive_neighbors <= 1) begin
					q_next[i*16 + j] = 0;
				end else if (alive_neighbors == 2) begin
					q_next[i*16 + j] = q[i*16 + j];
				end else if (alive_neighbors == 3) begin
					q_next[i*16 + j] = 1;
				end else begin
					// (alive_neighbors >= 4)
					q_next[i*16 + j] = 0;
				end
			end
		end
	end
	
endmodule
