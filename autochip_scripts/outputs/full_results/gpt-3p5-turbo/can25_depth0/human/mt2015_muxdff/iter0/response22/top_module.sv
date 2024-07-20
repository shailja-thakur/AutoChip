module flipflop(
	    input clk,
	    input D,
	    input Reset,
	    output reg Q
	);
	always @(posedge clk or posedge Reset) begin
		if (Reset)
			Q <= 0;
		else
			Q <= D;
	end
endmodule
module mux21(
	    input S,
	    input I0,
	    input I1,
	    output reg O
	);
	always @* begin
		if (S)
			O = I1;
		else
			O = I0;
	end
endmodule
module top_module(
	    input clk,
	    input L,
	    input q_in,
	    input r_in,
	    output reg Q
	);
	reg [2:0] q;

	flipflop ff0(
		.clk(clk),
		.D(q_in),
		.Reset(L),
		.Q(q[0])
	);
	flipflop ff1(
		.clk(clk),
		.D(q[1] ^ q[2]),
		.Reset(L),
		.Q(q[1])
	);
	flipflop ff2(
		.clk(clk),
		.D(q[0]),
		.Reset(L),
		.Q(q[2])
	);
	mux21 mux(
		.S(q[1]),
		.I0(r_in),
		.I1(q[2]),
		.O(Q)
    );
endmodule
