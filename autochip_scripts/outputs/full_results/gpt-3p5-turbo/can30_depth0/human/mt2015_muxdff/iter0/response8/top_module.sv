module flipflop(
	input clk,
	input D,
	output reg Q);

	always @(posedge clk) begin
		Q <= D;
	end
endmodule
module multiplexer(
	input [1:0] S,
	input D0,
	input D1,
	output reg Q);

	always @(S, D0, D1) begin
		case(S)
			2'b00: Q <= D0;
			2'b01: Q <= D1;
			default: Q <= 1'bx;
		endcase
	end
endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	wire [2:0] r;
	assign r = {r_in[1] ^ r_in[2], r_in[0], r_in[2]} ;

	flipflop flipflop_inst0(.clk(clk), .D(q_in), .Q(Q));
	flipflop flipflop_inst1(.clk(clk), .D(q_in), .Q(Q));
	flipflop flipflop_inst2(.clk(clk), .D(q_in), .Q(Q));

	multiplexer mux_inst0(.S({L, L}), .D0(flipflop_inst0.Q), .D1(r), .Q(Q));
	multiplexer mux_inst1(.S({L, L}), .D0(flipflop_inst1.Q), .D1(r), .Q(Q));
	multiplexer mux_inst2(.S({L, L}), .D0(flipflop_inst2.Q), .D1(r), .Q(Q));
endmodule
