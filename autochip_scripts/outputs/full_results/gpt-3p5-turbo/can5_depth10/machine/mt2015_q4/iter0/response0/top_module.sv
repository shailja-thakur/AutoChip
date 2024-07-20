module top_module(
	input x,
	input y,
	output z);

    wire a1, b1, a2, b2;
    wire a3, b3;

    // First gate
    and gate1(a1, x, y);
    // Second gate
    or gate2(b1, x, y);
    // Third gate
    xor gate3(z, a1, b1);

endmodule
