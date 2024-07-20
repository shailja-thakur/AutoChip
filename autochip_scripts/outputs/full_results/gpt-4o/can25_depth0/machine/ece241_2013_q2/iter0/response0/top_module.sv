module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Calculate the out_sop output
    wire and_cd = c & d;
    wire and_not_ab_c = (~a) & (~b) & c;
    assign out_sop = and_cd | and_not_ab_c;

    // Calculate intermediate wires for out_pos output
    wire pos0 = c & ((~b) | d) & ((~a) | b);
    wire pos1 = c & ((~b) | d) & ((~a) | d);
    
    // Assign out_pos based on the ternary condition
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
