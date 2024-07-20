module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    // Intermediate wires
    wire and_ab;
    wire and_cd;

    // First layer: AND gates
    assign and_ab = a & b;
    assign and_cd = c & d;

    // Second layer: OR gate
    assign out = and_ab | and_cd;

    // Inverted output
    assign out_n = ~out;

endmodule
