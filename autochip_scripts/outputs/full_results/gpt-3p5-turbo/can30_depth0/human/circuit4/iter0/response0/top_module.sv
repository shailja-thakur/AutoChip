module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
    // Using a bunch of AND, OR, and NOT gates to calculate q
    wire and_1, and_2, and_3, and_4, and_5;
    wire or_1, or_2;
    wire not_a, not_b, not_c, not_d;
    
    // NOT gates
    not not_g1 (a, not_a);
    not not_g2 (b, not_b);
    not not_g3 (c, not_c);
    not not_g4 (d, not_d);
    
    // AND gates
    and and_g1 (not_a, not_b, and_1);
    and and_g2 (and_1, not_c, and_2);
    and and_g3 (not_c, not_d, and_3);
    and and_g4 (and_2, and_3, and_4);
    
    // OR gates
    or or_g1 (and_4, b, or_1);
    or or_g2 (or_1, d, or_2);
    
    // Final output
    assign q = or_2;
endmodule
