module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
	
    // Define four 2-input AND gates
    wire and1_out;
    wire and2_out;
    wire and3_out;
    wire and4_out;
    
    and2x1 and1 (a, b, and1_out);
    and2x1 and2 (~a, b, and2_out);
    and2x1 and3 (~a, ~c, and3_out);
    and2x1 and4 (a, ~d, and4_out);
    
    // Define four 2-input OR gates
    wire or1_out;
    wire or2_out;
    wire or3_out;
    wire or4_out;
    
    or2x1 or1 (and1_out, and2_out, or1_out);
    or2x1 or2 (and3_out, and4_out, or2_out);
    or2x1 or3 (and1_out, and4_out, or3_out);
    or2x1 or4 (and2_out, and3_out, or4_out);
    
    // Define a 4-input OR gate
    wire or5_out;
    
    or4x1 or5 (or1_out, or2_out, or3_out, or4_out, or5_out);
    
    // Assign the output
    assign out = or5_out;
    
endmodule
