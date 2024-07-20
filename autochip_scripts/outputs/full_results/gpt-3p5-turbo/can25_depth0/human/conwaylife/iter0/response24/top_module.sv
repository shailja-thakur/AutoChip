module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);

	reg [255:0] next_q;
	reg [7:0] neighbors; 

	always @(posedge clk) begin
		if (load) begin
			q <= data; // Load initial state
		end else begin
			// Calculate next state
			for (integer i = 0; i < 256; i = i + 1) begin
				neighbors = q[i-16] + q[i-15] + q[i-1] + q[i+1] + q[i+15] + q[i+16] + q[i+17] + q[i-17];
				
				if (neighbors == 3) begin
					next_q[i] = 1;
				end else if (neighbors == 2 && q[i] == 1) begin
					next_q[i] = 1;
				end else begin
					next_q[i] = 0;
				end
			end
			q <= next_q;
		end
	end

endmodule
