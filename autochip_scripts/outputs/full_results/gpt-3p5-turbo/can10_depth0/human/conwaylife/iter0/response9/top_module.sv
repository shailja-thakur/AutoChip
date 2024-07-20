module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] q_next;
	
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			q <= q_next;
		end
	end
	
	always @* begin
		for (integer i = 0; i < 256; i = i + 1) begin
			integer x = i % 16;
			integer y = i / 16;
			
			integer north = (y == 0) ? 15 : y - 1;
			integer south = (y == 15) ? 0 : y + 1;
			integer west = (x == 0) ? 15 : x - 1;
			integer east = (x == 15) ? 0 : x + 1;
			
			integer nw = north * 16 + west;
			integer ne = north * 16 + east;
			integer sw = south * 16 + west;
			integer se = south * 16 + east;
			
			integer num_neighbors = q[nw] + q[north * 16 + x] + q[ne] + q[y * 16 + west] + q[y * 16 + east] + q[sw] + q[south * 16 + x] + q[se];
			
			if (num_neighbors <= 1 || num_neighbors >= 4) begin
				q_next[i] = 0;
			end else if (num_neighbors == 3) begin
				q_next[i] = 1;
			end else begin
				q_next[i] = q[i];
			end
		end
	end
	
endmodule
