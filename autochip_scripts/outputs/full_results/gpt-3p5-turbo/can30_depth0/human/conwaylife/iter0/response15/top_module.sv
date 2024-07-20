module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;
	always @(posedge clk) begin
		if (load)
			next_q <= data;
		else begin
			for (integer i=0; i<256; i=i+1) begin
				integer row = i / 16;
				integer col = i % 16;
				integer ne_count = 0;
				
				// Count the number of alive neighbors
				if (q[(row-1)*16 + ((col+1)%16)]) ne_count = ne_count + 1;
				if (q[(row-1)*16 + col]) ne_count = ne_count + 1;
				if (q[(row-1)*16 + ((col+15)%16)]) ne_count = ne_count + 1;
				if (q[row*16 + ((col+1)%16)]) ne_count = ne_count + 1;
				if (q[row*16 + ((col+15)%16)]) ne_count = ne_count + 1;
				if (q[(row+1)*16 + ((col+1)%16)]) ne_count = ne_count + 1;
				if (q[(row+1)*16 + col]) ne_count = ne_count + 1;
				if (q[(row+1)*16 + ((col+15)%16)]) ne_count = ne_count + 1;
				
				// Update cell state based on neighbor count
				if (ne_count <= 1)
					next_q[i] <= 0;
				else if (ne_count == 2)
					next_q[i] <= q[i];
				else if (ne_count == 3)
					next_q[i] <= 1;
				else
					next_q[i] <= 0;
			end
		end
	end
	assign q = next_q;
endmodule
