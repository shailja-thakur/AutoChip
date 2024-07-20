module flipflop(
	input clk,
	input D,
	output reg Q);

	always @(posedge clk) begin
		Q <= D;
	end
	
endmodule
module mux_2to1(
	input S,
	input D0,
	input D1,
	output reg Y);

	always @(S or D0 or D1) begin
		if (S) begin
			Y <= D1;
		end else begin
			Y <= D0;
		end
	end
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire [2:0] r;
	wire [2:0] q;

	flipflop ff0(
		.clk(clk),
		.D(q_in),
		.Q(q[0])
	);
	
	flipflop ff1(
		.clk(clk),
		.D(q[1]),
		.Q(q[1])
	);
	
	flipflop ff2(
		.clk(clk),
		.D(q[2]),
		.Q(q[2])
	);
	
	mux_2to1 mux(
		.S(L),
		.D0(r_in),
		.D1(q[2]),
		.Y(r[0])
	);

	assign Q = r[0];

endmodule
