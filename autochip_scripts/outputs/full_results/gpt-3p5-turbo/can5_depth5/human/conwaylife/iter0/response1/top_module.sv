module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	reg [255:0] q_next;
	
	always @(posedge clk) begin
		if(load) begin
			q <= data;
		end
		else begin
			q <= q_next;
		end
	end
	
	// Calculate the next state of each cell
	always @(q) begin
		for (integer i = 0; i < 256; i = i + 1) begin
			// Determine the row and column of the current cell
			integer row = i / 16;
			integer col = i % 16;
			
			// Count the number of alive neighbors
			integer num_neighbors = 0;
			
			// Cell above
			if (q[((row-1)*16) + col] == 1)
				num_neighbors = num_neighbors + 1;
			
			// Cell below
			if (q[((row+1)*16) + col] == 1)
				num_neighbors = num_neighbors + 1;
			
			// Cell to the left
			if (q[(row*16) + (col-1)] == 1)
				num_neighbors = num_neighbors + 1;
			
			// Cell to the right
			if (q[(row*16) + (col+1)] == 1)
				num_neighbors = num_neighbors + 1;
			
			// Top-left corner
			if (row == 0 && col == 0) begin
				if (q[240] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[15] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[16] == 1)
					num_neighbors = num_neighbors + 1;
			end
			
			// Bottom-left corner
			if (row == 15 && col == 0) begin
				if (q[224] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[239] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[240] == 1)
					num_neighbors = num_neighbors + 1;
			end
			
			// Top-right corner
			if (row == 0 && col == 15) begin
				if (q[15] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[0] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[31] == 1)
					num_neighbors = num_neighbors + 1;
			end
			
			// Bottom-right corner
			if (row == 15 && col == 15) begin
				if (q[239] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[224] == 1)
					num_neighbors = num_neighbors + 1;
				if (q[15] == 1)
					num_neighbors = num_neighbors + 1;
			end
			
			// Update the cell based on the number of neighbors
			if (num_neighbors == 0 || num_neighbors == 1)
				q_next[i] = 0;
			else if (num_neighbors == 2)
				q_next[i] = q[i];
			else if (num_neighbors == 3)
				q_next[i] = 1;
			else if (num_neighbors >= 4)
				q_next[i] = 0;
		end
	end
	
endmodule
