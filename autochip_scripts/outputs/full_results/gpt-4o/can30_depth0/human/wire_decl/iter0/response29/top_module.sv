module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

    wire and1_out, and2_out;
    
    // First layer of AND gates
    and u_and1 (and1_out, a, b);
    and u_and2 (and2_out, c, d);
    
    // Second layer of OR gate
    or u_or1 (out, and1_out, and2_out);
    
    // NOT gate for inverted output
    not u_not1 (out_n, out);
    
endmodule
