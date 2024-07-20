module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n ); 

	wire inter_wire_1;
	wire inter_wire_2;

	and gate_1 (inter_wire_1, a, b);
	and gate_2 (inter_wire_2, c, d);
	or  gate_3 (out, inter_wire_1, inter_wire_2);
	not gate_4 (out_n, out);

endmodule
