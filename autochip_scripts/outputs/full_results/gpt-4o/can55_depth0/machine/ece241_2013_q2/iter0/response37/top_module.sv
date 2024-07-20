module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Generate out_sop as SOP expression
    wire and_cd = c & d;
    wire and_notab_c = (~a) & (~b) & c;
    assign out_sop = and_cd | and_notab_c;
    
    // Generate out_pos as POS expression
    wire pos0 = c & ((~b) | d) & ((~a) | b);
    wire pos1 = c & ((~a) | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
