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
	
	// Helper function to count the number of alive neighbors
	function integer count_neighbors;
		input [255:0] q;
		input integer x;
		input integer y;
		integer count;
		
		begin
			count = 0;
			
			// North
			if (q[(x-1)*16 + y]) begin
				count = count + 1;
			end
			
			// South
			if (q[(x+1)*16 + y]) begin
				count = count + 1;
			end
			
			// West
			if (q[x*16 + (y-1)]) begin
				count = count + 1;
			end
			
			// East
			if (q[x*16 + (y+1)]) begin
				count = count + 1;
			end
			
			// Northwest
			if (q[(x-1)*16 + (y-1)]) begin
				count = count + 1;
			end
			
			// Northeast
			if (q[(x-1)*16 + (y+1)]) begin
				count = count + 1;
			end
			
			// Southwest
			if (q[(x+1)*16 + (y-1)]) begin
				count = count + 1;
			end
			
			// Southeast
			if (q[(x+1)*16 + (y+1)]) begin
				count = count + 1;
			end
			
			return count;
		end
	endfunction
	
	// Update the game state
	always @(q) begin
		integer i, j;
		integer x, y;
		integer num_neighbors;
		
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				
				x = i;
				y = j;
				
				num_neighbors = count_neighbors(q, x, y);
				
				if (num_neighbors == 0 || num_neighbors == 1) begin
					q_next[i*16 + j] = 0;
				end else if (num_neighbors == 2) begin
					q_next[i*16 + j] = q[i*16 + j];
				end else if (num_neighbors == 3) begin
					q_next[i*16 + j] = 1;
				end else begin
					q_next[i*16 + j] = 0;
				end
				
			end
		end
	end
	
endmodule
