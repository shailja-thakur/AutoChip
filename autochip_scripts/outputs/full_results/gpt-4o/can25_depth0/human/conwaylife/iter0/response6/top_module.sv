module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [3:0] neighbors [0:255];

	integer i, j;

	always @(*) begin
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				integer count;
				count = q[((i+15)%16)*16 + ((j+15)%16)] +
						q[((i+15)%16)*16 + j] +
						q[((i+15)%16)*16 + ((j+1)%16)] +
						q[i*16 + ((j+15)%16)] +
						q[i*16 + ((j+1)%16)] +
						q[((i+1)%16)*16 + ((j+15)%16)] +
						q[((i+1)%16)*16 + j] +
						q[((i+1)%16)*16 + ((j+1)%16)];

				if (count < 2 || count > 3)
					neighbors[i*16 + j] = 0;
				else if (count == 3)
					neighbors[i*16 + j] = 1;
				else
					neighbors[i*16 + j] = q[i*16 + j];
			}
		}
	end

	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			for (i = 0; i < 16*16; i = i + 1)
				q[i] <= neighbors[i];
	end
endmodule
