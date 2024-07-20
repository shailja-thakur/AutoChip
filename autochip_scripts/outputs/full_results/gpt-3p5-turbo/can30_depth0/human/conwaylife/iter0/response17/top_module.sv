module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] q_next;

	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= q_next;
	end

	generate
		genvar i;
		genvar j;

		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				wire [7:0] neighbors;
				wire is_corner;

				assign neighbors[0] = q_next[(i+15)*16 + (j+1)];
				assign neighbors[1] = q_next[(i+15)*16 + j];
				assign neighbors[2] = q_next[(i+15)*16 + (j+15)];
				assign neighbors[3] = q_next[(i)*16 + (j+1)];
				assign neighbors[4] = q_next[(i)*16 + (j+15)];
				assign neighbors[5] = q_next[(i+1)*16 + (j+1)];
				assign neighbors[6] = q_next[(i+1)*16 + j];
				assign neighbors[7] = q_next[(i+1)*16 + (j+15)];

				assign is_corner = (i == 0 && (j == 0 || j == 15)) || (i == 15 && (j == 0 || j == 15));
				
				always @(*) begin
					case (q_next[i*16 + j])
						1'b0:
							if (neighbors <= 1 || neighbors >= 4)
								q_next[i*16 + j] = 1'b0;
							else 
								q_next[i*16 + j] = 1'b1;
						1'b1:
							if (neighbors == 2 || neighbors == 3)
								q_next[i*16 + j] = 1'b1;
							else 
								q_next[i*16 + j] = 1'b0;
					endcase
				end
			end
		end
	endgenerate
endmodule
