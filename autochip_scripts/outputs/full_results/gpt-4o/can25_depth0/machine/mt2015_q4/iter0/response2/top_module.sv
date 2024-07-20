module top_module(
	input x,
	input y,
	output z);

    wire out1, out2;

    // First gate (AND gate as an example)
    assign out1 = x & y;

    // Second gate (OR gate as an example)
    assign out2 = x | y;

    // Third gate (XOR gate as an example)
    assign z = out1 ^ out2;

endmodule
