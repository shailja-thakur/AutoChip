module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    // Intermediate wires for AND gate outputs
    wire and1_out;
    wire and2_out;

    // First layer: two AND gates
    and g1 (and1_out, a, b);
    and g2 (and2_out, c, d);

    // Second layer: OR gate
    or g3 (out, and1_out, and2_out);

    // Inverted output
    not g4 (out_n, out);
endmodule
