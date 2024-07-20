module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    // Intermediate wires
    wire and1_out;
    wire and2_out;

    // First layer: AND gates
    and and1 (and1_out, a, b);
    and and2 (and2_out, c, d);
    
    // Second layer: OR gate
    or or1 (out, and1_out, and2_out);
    
    // Inverted output
    not not1 (out_n, out);

endmodule
