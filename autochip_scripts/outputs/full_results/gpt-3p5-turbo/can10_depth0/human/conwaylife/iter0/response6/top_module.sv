module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);
	
	reg [255:0] q_next;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Compute next state of each cell
			for (integer i = 0; i < 256; i = i + 1) begin
				// Compute number of neighbors for cell i
				integer neighbors = 0;
				
				integer row = i / 16;
				integer col = i % 16;
				
				integer left_col = col - 1;
				if (left_col < 0) begin
					left_col = 15;
				end
				
				integer right_col = col + 1;
				if (right_col > 15) begin
					right_col = 0;
				end
				
				integer up_row = row - 1;
				if (up_row < 0) begin
					up_row = 15;
				end
				
				integer down_row = row + 1;
				if (down_row > 15) begin
					down_row = 0;
				end
				
				integer left_index = up_row * 16 + left_col;
				integer center_index = up_row * 16 + col;
				integer right_index = up_row * 16 + right_col;
				integer up_index = row * 16 + col;
				integer down_index = down_row * 16 + col;
				integer left_down_index = down_row * 16 + left_col;
				integer center_down_index = down_row * 16 + col;
				integer right_down_index = down_row * 16 + right_col;
				
				if (q[left_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[center_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[right_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[up_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[down_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[left_down_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[center_down_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				if (q[right_down_index] == 1) begin
					neighbors = neighbors + 1;
				end
				
				// Update cell state based on number of neighbors
				if (neighbors == 0 || neighbors == 1) begin
					q_next[i] = 0;
				end else if (neighbors == 2) begin
					q_next[i] = q[i];
				end else if (neighbors == 3) begin
					q_next[i] = 1;
				end else begin
					q_next[i] = 0;
				end
			end
			
			// Update current state
			q <= q_next;
		end
	end
	
endmodule
