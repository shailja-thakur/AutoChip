module top_module(
	input x,
	input y,
	output z);

    wire a, b;

    and gate1(a, b, x, y);
    or gate2(b, a, x, y);
    xor gate3(z, a, b);
    
endmodule
