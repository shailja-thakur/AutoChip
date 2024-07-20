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
	input A,
	input B,
	input SEL,
	output reg OUT
	);
	
	always @(A or B or SEL) begin
		if (SEL == 0)
			OUT <= A;
		else
			OUT <= B;
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	wire r0, r1, r2;
	
	flipflop ff0(.clk(clk), .D(r0), .Q());
	flipflop ff1(.clk(clk), .D(r1), .Q());
	flipflop ff2(.clk(clk), .D(r2), .Q());
	
	mux_2to1 mux0(.A(q_in), .B(r_in), .SEL(L), .OUT(r0));
	mux_2to1 mux1(.A(r2), .B(ff0.Q), .SEL(L), .OUT(r1));
	mux_2to1 mux2(.A(ff1.Q), .B(ff2.Q), .SEL(L), .OUT(Q));
	
endmodule
