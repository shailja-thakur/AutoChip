module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	integer i, j;
	reg [3:0] neighbors[15:0][15:0];

	// Helper function to count alive neighbors with toroidal wrapping
	function [3:0] count_neighbors;
		input integer x, y;
		integer ix, iy;
		begin
			count_neighbors = 0;
			for (ix = -1; ix <= 1; ix = ix + 1) begin
				for (iy = -1; iy <= 1; iy = iy + 1) begin
					if (ix != 0 || iy != 0) begin
						if (q[((x + ix + 16) % 16) * 16 + ((y + iy + 16) % 16)] == 1)
							count_neighbors = count_neighbors + 1;
					end
				end
			end
		end
	endfunction

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			// Initialize neighbors counts
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					neighbors[i][j] = count_neighbors(i, j);
				end
			end
            
			// Update the grid according to the rules
			for (i = 0; i < 16; i = i + 1) begin
				for (j = 0; j < 16; j = j + 1) begin
					case (neighbors[i][j])
						4'b0000, 4'b0001: q[i*16+j] <= 0;
						4'b0010: q[i*16+j] <= q[i*16+j];
						4'b0011: q[i*16+j] <= 1;
						default: q[i*16+j] <= 0;
					endcase
				end
			end
		end
	end

endmodule
