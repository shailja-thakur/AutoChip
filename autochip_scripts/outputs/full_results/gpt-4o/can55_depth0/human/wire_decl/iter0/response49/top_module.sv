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
    
    // AND gates
    and and1 (and1_out, a, b);
    and and2 (and2_out, c, d);
    
    // OR gate
    or  or1  (out, and1_out, and2_out);
    
    // NOT gate
    not not1 (out_n, out);

endmodule
