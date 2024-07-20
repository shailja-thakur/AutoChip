module flipflop(
	input clk,
	input D,
	output reg Q
);

	always @(posedge clk) begin
		Q <= D;	
	end
	
endmodule
module mux_2to1(
	input S,
	input I0,
	input I1,
	output reg O
);

	always @(S or I0 or I1) begin
		if(S == 0) begin
			O <= I0;
		end else begin
			O <= I1;
		end
	end
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

	wire q_out;
	wire [2:0] r;

	flipflop ff(
		.clk(clk),
		.D(q_out),
		.Q(Q)
	);
	
	mux_2to1 m1(
		.S(L),
		.I0(r[1]),
		.I1(r[2]),
		.O(q_out)
	);
	
	mux_2to1 m2(
		.S(L),
		.I0(q_in[0]),
		.I1(r_in),
		.O(r[0])
	);
	
	mux_2to1 m3(
		.S(L),
		.I0(q_in[2]),
		.I1(r_in),
		.O(r[1])
	);
	
endmodule
