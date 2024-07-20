module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	wire intermediate_wire_1;
	wire intermediate_wire_2;

	assign intermediate_wire_1 = a & b;
	assign intermediate_wire_2 = c & d;

	assign out = intermediate_wire_1 | intermediate_wire_2;
	assign out_n = ~out;

endmodule
