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
		q_next = q;
		for (integer i = 0; i < 16; i = i + 1)
		begin
			// Update neighbors for each row
			if (i == 0)
			begin
				q_left = q[15:0];
				q_right = q[31:16];
				q_top = q[240];
				q_bottom = q[255];
			end
			else if (i == 15)
			begin
				q_left = q[(i * 16) - 1];
				q_right = q[i * 16];
				q_top = q[i * 16 - 16];
				q_bottom = q[0];
			end
			else
			begin
				q_left = q[(i * 16) - 1];
				q_right = q[i * 16];
				q_top = q[i * 16 - 16];
				q_bottom = q[i * 16 + 16];
			end

			// Update neighbors for each cell in the row
			for (integer j = 0; j < 16; j = j + 1)
			begin
				// Calculate number of neighbors
				q_neighbors = 0;
				
				if(i==0 && j==0)
				begin
					q_neighbors = q_top + q_right + q[(i+1)*16+j] + q[15*16+j] + q[15*16+15];
				end
				else if(i==0 && j==15)
				begin
					q_neighbors = q_top + q_right + q[(i+1)*16+j] + q[15*16+j] + q[15*16+j-1];
				end
				else if(i==15 && j==0)
				begin
					q_neighbors = q_bottom + q_left + q[(i-1)*16+j] + q[0*16+j] + q[0*16+15];
				end
				else if(i==15 && j==15)
				begin
					q_neighbors = q_bottom + q_left + q[(i-1)*16+j] + q[0*16+j] + q[0*16+j-1];
				end
				else if(i==0)
				begin
					q_neighbors = q_top + q_left + q_right + q[(i+1)*16+j] + q[(i+1)*16+j-1] + q[(i+1)*16+j+1] + q[15*16+j] + q[15*16+j-1] + q[15*16+j+1];
				end
				else if(i==15)
				begin
					q_neighbors = q_bottom + q_left + q_right + q[(i-1)*16+j] + q[(i-1)*16+j-1] + q[(i-1)*16+j+1] + q[0*16+j] + q[0*16+j-1] + q[0*16+j+1];
				end
				else if(j==0)
				begin
					q_neighbors = q_left + q_top + q_bottom + q[(i+1)*16+j] + q[(i+1)*16+j+1] + q[(i-1)*16+j] + q[(i-1)*16+j+1] + q[i*16+15] + q[i*16+1];
				end
				else if(j==15)
				begin
					q_neighbors = q_right + q_top + q_bottom + q[(i+1)*16+j] + q[(i+1)*16+j-1] + q[(i-1)*16+j] + q[(i-1)*16+j-1] + q[i*16] + q[i*16-1];
				end
				else
				begin
					q_neighbors = q_left + q_right + q_top + q_bottom + q[(i+1)*16+j] + q[(i+1)*16+j-1] + q[(i+1)*16+j+1] + q[(i-1)*16+j] + q[(i-1)*16+j-1] + q[(i-1)*16+j+1];
				end

				// Calculate next state for the cell based on neighbors
				case (q_neighbors)
					8'b00000001:
						q_next[i * 16 + j] = 0;
					8'b00000010:
						q_next[i * 16 + j] = q[i * 16 + j];
					8'b00000011:
						q_next[i * 16 + j] = 1;
					8'b00000100, 8'b00000101, 8'b00000110, 8'b00000111, 8'b00001000, 8'b00001001, 8'b00001010, 8'b00001011:
						q_next[i * 16 + j] = 0;
				endcase
			end
		end
	end
endmodule
