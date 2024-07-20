module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
	
	reg [255:0] new_q;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			for (integer i = 0; i < 16; i = i + 1) begin
				for (integer j = 0; j < 16; j = j + 1) begin
					integer count = 0;
					if (q[((i-1) & 15)*16 + ((j-1) & 15)]) count = count + 1;
					if (q[((i-1) & 15)*16 + j]) count = count + 1;
					if (q[((i-1) & 15)*16 + ((j+1) & 15)]) count = count + 1;
					if (q[(i*16) + ((j-1) & 15)]) count = count + 1;
					if (q[(i*16) + ((j+1) & 15)]) count = count + 1;
					if (q[((i+1) & 15)*16 + ((j-1) & 15)]) count = count + 1;
					if (q[((i+1) & 15)*16 + j]) count = count + 1;
					if (q[((i+1) & 15)*16 + ((j+1) & 15)]) count = count + 1;
					
					if (count == 0 || count == 1) begin
						new_q[(i*16) + j] = 0;
					end else if (count == 2) begin
						new_q[(i*16) + j] = q[(i*16) + j];
					end else if (count == 3) begin
						new_q[(i*16) + j] = 1;
					end else begin
						new_q[(i*16) + j] = 0;
					end
				end
			end
			
			q <= new_q;
		end
	end
	
endmodule
