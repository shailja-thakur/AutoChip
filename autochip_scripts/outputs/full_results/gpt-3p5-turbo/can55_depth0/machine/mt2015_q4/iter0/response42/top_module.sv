module top_module(
	input x,
	input y,
	output z);

    wire a, b;
    wire gate1_out, gate2_out;

    and gate1(a, y, gate1_out);
    and gate2(x, b, gate2_out);
    or gate3(gate1_out, gate2_out, z);
endmodule
