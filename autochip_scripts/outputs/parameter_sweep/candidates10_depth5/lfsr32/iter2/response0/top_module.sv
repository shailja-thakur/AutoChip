module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] next_q;

	always @(posedge clk or posedge reset)
	begin
		if(reset)
			q <= 32'h1;
		else
		begin
			next_q[0] <= q[30] ^ q[21] ^ q[1] ^ q[0];  // changed q[31] to q[30]
			next_q[1] <= q[0];
			next_q[2] <= q[1];
			next_q[31:3] <= q[30:2];  // changed q[31:3] to q[30:2]
			q <= next_q;
		end
	end
endmodule
