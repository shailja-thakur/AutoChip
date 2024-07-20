module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // The first gate is an AND gate
    and gate1(out1, x, y);
	
    // The second gate is an OR gate
    or gate2(out2, y, x);
	
    // The third gate can be updated based on required logical function, suppose it needs to be AND gate again
    and gate3(z, out1, out2);

endmodule
