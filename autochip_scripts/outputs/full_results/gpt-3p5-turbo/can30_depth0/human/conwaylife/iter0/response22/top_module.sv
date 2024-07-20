module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	reg [255:0] next_q;
	reg [15:0] ngbr_count [255:0];
	
	// Calculate the number of neighbors for each cell
	always @* begin
		for (int i = 0; i < 256; i = i + 1) begin
			ngbr_count[i] = 0;
			
			// Calculate the row and column indices for the current cell
			int row = i / 16;
			int col = i % 16;
			
			// Check each neighbor of the current cell
			// Left neighbor
			if (col == 0)
				ngbr_count[i] = ngbr_count[i] + q[i + 15];
			else
				ngbr_count[i] = ngbr_count[i] + q[i - 1];
			
			// Right neighbor
			if (col == 15)
				ngbr_count[i] = ngbr_count[i] + q[i - 15];
			else
				ngbr_count[i] = ngbr_count[i] + q[i + 1];
			
			// Top neighbor
			if (row == 0)
				ngbr_count[i] = ngbr_count[i] + q[i + 240];
			else
				ngbr_count[i] = ngbr_count[i] + q[i - 16];
			
			// Bottom neighbor
			if (row == 15)
				ngbr_count[i] = ngbr_count[i] + q[i - 240];
			else
				ngbr_count[i] = ngbr_count[i] + q[i + 16];
			
			// Top-left neighbor
			if (row == 0 && col == 0)
				ngbr_count[i] = ngbr_count[i] + q[255];
			else if (row == 0)
				ngbr_count[i] = ngbr_count[i] + q[(row + 15) * 16 + col - 1];
			else if (col == 0)
				ngbr_count[i] = ngbr_count[i] + q[(row - 1) * 16 + 15];
			else
				ngbr_count[i] = ngbr_count[i] + q[(row - 1) * 16 + col - 1];
			
			// Top-right neighbor
			if (row == 0 && col == 15)
				ngbr_count[i] = ngbr_count[i] + q[0];
			else if (row == 0)
				ngbr_count[i] = ngbr_count[i] + q[(row + 15) * 16 + col + 1];
			else if (col == 15)
				ngbr_count[i] = ngbr_count[i] + q[(row - 1) * 16];
			else
				ngbr_count[i] = ngbr_count[i] + q[(row - 1) * 16 + col + 1];
			
			// Bottom-left neighbor
			if (row == 15 && col == 0)
				ngbr_count[i] = ngbr_count[i] + q[240];
			else if (row == 15)
				ngbr_count[i] = ngbr_count[i] + q[(row - 15) * 16 + col - 1];
			else if (col == 0)
				ngbr_count[i] = ngbr_count[i] + q[(row + 1) * 16 + 15];
			else
				ngbr_count[i] = ngbr_count[i] + q[(row + 1) * 16 + col - 1];
			
			// Bottom-right neighbor
			if (row == 15 && col == 15)
				ngbr_count[i] = ngbr_count[i] + q[255];
			else if (row == 15)
				ngbr_count[i] = ngbr_count[i] + q[(row - 15) * 16 + col + 1];
			else if (col == 15)
				ngbr_count[i] = ngbr_count[i] + q[(row + 1) * 16];
			else
				ngbr_count[i] = ngbr_count[i] + q[(row + 1) * 16 + col + 1];
		end
	end
	
	// Update the game state every clock cycle
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (int i = 0; i < 256; i = i + 1) begin
				case (ngbr_count[i])
					2: next_q[i] = q[i];
					3: next_q[i] = 1;
					default: next_q[i] = 0;
				endcase
			end
			
			q <= next_q;
		end
	end
endmodule
