module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] next_q;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			next_q <= 5'b1;
		else
			next_q <= {q[3] ^ q[0], q[4:1]};
	end
	
	always @(posedge clk) begin
		if (reset)
			q <= next_q;
		else
			q <= next_q[4:0];
	end
	
endmodule
