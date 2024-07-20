module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] next_q;
	
	always @(posedge clk) begin
		if (reset)
			next_q <= 1;
		else begin
			next_q[4] = q[4] ^ q[2] ^ q[0];
			next_q[3:0] = q[4:1];
		end
	end
	
	always @(posedge clk) begin
		if (reset)
			q <= 1;
		else
			q <= next_q;
	end
	
endmodule
