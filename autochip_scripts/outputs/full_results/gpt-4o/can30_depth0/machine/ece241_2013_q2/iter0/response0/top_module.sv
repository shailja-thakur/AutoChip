module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Generating the out_sop (Sum-of-Products) output
    wire sop1, sop2;
    assign sop1 = c & d; // AND of c and d
    assign sop2 = (~a) & (~b) & c; // AND of NOT a, NOT b, and c
    assign out_sop = sop1 | sop2; // OR of the two results

    // Generating the out_pos (Product-of-Sums) output
    wire pos0, pos1;
    assign pos0 = c & ((~b) | d) & ((~a) | b); // AND of c, OR of NOT b and d, OR of NOT a and b
    assign pos1 = c & ((~b) | d) & ((~a) | d); // AND of c, OR of NOT b and d, OR of NOT a and d
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx; // ternary expression to check if pos0 and pos1 are equal
    
endmodule
