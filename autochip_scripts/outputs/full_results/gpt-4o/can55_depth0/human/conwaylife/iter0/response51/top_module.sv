module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	// We're creating a 16x16 grid, using 256 bits
	reg [255:0] next_q;
	integer i;
	integer j;
	
	always @(*) begin
		// Generate next state based on current state (q)
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				int count = 0;

				// Count the alive neighbours (consider the toroidal wrapping)
				count = q[(i*16 + ((j+15)%16))] + q[(i*16 + ((j+1)%16))] +
						q[(((i+15)%16)*16 + j)] + q[(((i+1)%16)*16 + j)] +
						q[(((i+15)%16)*16 + ((j+15)%16))] + q[(((i+15)%16)*16 + ((j+1)%16))] +
						q[(((i+1)%16)*16 + ((j+15)%16))] + q[(((i+1)%16)*16 + ((j+1)%16))];

				case (count)
					0, 1: next_q[i*16 + j] = 0;
					2: next_q[i*16 + j] = q[i*16 + j];
					3: next_q[i*16 + j] = 1;
					default: next_q[i*16 + j] = 0;
				endcase
			end
		end
	end

	always @(posedge clk) begin
		if (load)
			q <= data;
		else
			q <= next_q;
	end
endmodule
