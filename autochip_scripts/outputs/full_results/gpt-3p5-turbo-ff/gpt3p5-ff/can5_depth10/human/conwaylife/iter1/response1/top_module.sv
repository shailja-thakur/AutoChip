module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] q_next;
	always @(posedge clk)
	begin
		if (load)
			q <= data;
		else
			q <= q_next;
	end

	// 16x16 grid
	reg [15:0] q_row, q_left, q_right;
	reg q_top, q_bottom;
	reg [7:0] q_neighbors;
	reg q_corner_top_left, q_corner_top_right, q_corner_bottom_left, q_corner_bottom_right;

	// Generate q_next
	always @(*)
	begin
		// Calculate next state for each cell
		for (integer i = 0; i < 16; i = i + 1)
		begin
			// Update neighbors for each row
			if (i == 0)
				q_top = q[240];
			else
				q_top = q[i * 16 - 16];
			
			if (i == 15)
				q_bottom = q[0];
			else
				q_bottom = q[i * 16 + 16];
			
			// Update neighbors for each cell in the row
			for (integer j = 0; j < 16; j = j + 1)
			begin
				// Update neighbors
				if (j == 0)
				begin
					q_left = q[(i * 16) + 15];
					q_right = q[(i * 16) + 1];
					q_neighbors = {q_left, q_top, q_top, q_right, q_right, q_bottom, q_bottom, q_left};
				end
				else if (j == 15)
				begin
					q_left = q[(i * 16) + 14];
					q_right = q[(i * 16)];
					q_neighbors = {q_left, q_left, q_top, q_top, q_right, q_bottom, q_bottom, q_right};
				end
				else
				begin
					q_left = q[(i * 16) + j - 1];
					q_right = q[(i * 16) + j + 1];
					q_neighbors = {q_left, q_left, q_top, q_top, q_right, q_right, q_bottom, q_bottom};
				end

				// Calculate next state for the cell based on neighbors
				if (q_neighbors == 8'b00000001)
					q_next[i * 16 + j] = 0;
				else if (q_neighbors == 8'b00000010)
					q_next[i * 16 + j] = q[i * 16 + j];
				else if (q_neighbors == 8'b00000011)
					q_next[i * 16 + j] = 1;
				else
					q_next[i * 16 + j] = 0;
			end
		end
	end
endmodule
