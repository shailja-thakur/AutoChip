module flipflop(
	input clk,
	input D,
	output reg Q
	);
	
	always @(posedge clk)
		Q <= D;
	
endmodule
module mux_2to1(
	input I0,
	input I1,
	input S,
	output reg O
	);
	
	always @(*)
		if (S == 0)
			O = I0;
		else
			O = I1;
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
	);
	
	wire q0, q1, q2;
	wire d0, d1, d2;
	wire s0, s1, s2;
	
	flipflop ff0(.clk(clk), .D(d0), .Q(q0));
	flipflop ff1(.clk(clk), .D(d1), .Q(q1));
	flipflop ff2(.clk(clk), .D(d2), .Q(q2));
	
	mux_2to1 mux0(.I0(q0), .I1(q_in), .S(s0), .O(d0));
	mux_2to1 mux1(.I0(q1), .I1(q_in), .S(s1), .O(d1));
	mux_2to1 mux2(.I0(q2), .I1(q_in), .S(s2), .O(d2));

	always @(posedge clk) begin
		if (L) begin
			Q <= r_in;
		end else begin
			Q <= {q1 ^ q2, q0, q2};
		end
	end
	
endmodule
