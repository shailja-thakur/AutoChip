module flipflop(
	input clk,
	input r,
	output reg q);
	
	always @(posedge clk) begin
		if (L)
			q <= r;
		else
			q <= q;
	end
	
endmodule
module mux(
	input [2:0] r,
	input L,
	output reg q);
	
	always @(r or L) begin
		if (L) 
			q <= r;
		else
			q <= (r[1] ^ r[2]);
	end
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	wire [2:0] q1, q2, q3;
	
	flipflop FF1(
		.clk(clk),
		.r(q1),
		.q(q2)
	);
	
	flipflop FF2(
		.clk(clk),
		.r(q2),
		.q(q3)
	);
	
	flipflop FF3(
		.clk(clk),
		.r(q3),
		.q(Q)
	);
	
	mux M(
		.r(r_in),
		.L(L),
		.q(q1)
	);
	
endmodule
