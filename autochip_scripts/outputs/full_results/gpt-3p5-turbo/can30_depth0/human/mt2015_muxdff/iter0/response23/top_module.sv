module flipflop(
	input clk,
	input D,
	output reg Q);

	always @(posedge clk) begin
		Q <= D;
	end
	
endmodule
module mux21(
	input [1:0] S,
	input D0,
	input D1,
	output reg Y);
	
	always @(S) begin
		case(S)
			2'b00: Y <= D0;
			2'b01: Y <= D1;
			2'b10: Y <= D0;
			2'b11: Y <= D1;
		endcase
	end
	
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);
	
	wire [2:0] q;
	wire [1:0] s;
	
	flipflop ff0 (
		.clk(clk),
		.D(r_in),
		.Q(q[0])
	);
	
	flipflop ff1 (
		.clk(clk),
		.D(q_in),
		.Q(q[1])
	);
	
	flipflop ff2 (
		.clk(clk),
		.D({q[1], q[0]}),
		.Q(q[2])
	);
	
	mux2_1 mux (
		.S({L, q[2]}),
		.D0(r_in),
		.D1(q[2]),
		.Y(Q)
	);
	
endmodule
