module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			next_q = q;
			for (integer i = 0; i < 256; i = i + 1) begin
				integer neighbors = 0;
				integer row = i / 16;
				integer column = i % 16;

				if (q[((row+15)%16)*16 + (column+15)%16]) begin
					neighbors = neighbors + 1;
				end
				if (q[((row+15)%16)*16 + column]) begin
					neighbors = neighbors + 1;
				end
				if (q[((row+15)%16)*16 + (column+1)%16]) begin
					neighbors = neighbors + 1;
				end
				if (q[(row*16 + (column+15)%16)]) begin
					neighbors = neighbors + 1;
				end
				if (q[(row*16 + (column+1)%16)]) begin
					neighbors = neighbors + 1;
				end
				if (q[((row+1)%16)*16 + (column+15)%16]) begin
					neighbors = neighbors + 1;
				end
				if (q[((row+1)%16)*16 + column]) begin
					neighbors = neighbors + 1;
				end
				if (q[((row+1)%16)*16 + (column+1)%16]) begin
					neighbors = neighbors + 1;
				end

				if (neighbors <= 1 || neighbors >= 4) begin
					next_q[i] = 0;
				end else if (neighbors == 3) begin
					next_q[i] = 1;
				end
			end
			q <= next_q;
		end
	end

endmodule
