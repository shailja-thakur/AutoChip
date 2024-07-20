module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	// Create temporary registers for the next state of the game
	reg [255:0] q_next;
	
	// Synchronous process to update the game state
	always @(posedge clk) begin
		if (load) begin
			// Load initial state
			q <= data;
		end else begin
			// Update game state based on the number of neighbors
			for (int i = 0; i < 256; i = i + 1) begin
				case (q[i] + q[(i+1)%256] + q[(i-1)%256] +
					  q[(i+16)%256] + q[(i-16)%256] +
					  q[(i+15)%256] + q[(i+17)%256] +
					  q[(i-15)%256] + q[(i-17)%256])
					3: q_next[i] = 1; // Cell becomes 1 with 3 neighbors
					2: q_next[i] = q[i]; // Cell state does not change with 2 neighbors
					default: q_next[i] = 0; // Cell becomes 0 with 0-1 or 4+ neighbors
				endcase
			end
			
			q <= q_next; // Update the current state with the next state
		end
	end
endmodule
