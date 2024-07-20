module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate out_sop using Sum-of-Products (SOP) expression
    wire and_cd = c & d;
    wire and_notab_c = (~a) & (~b) & c;
    assign out_sop = and_cd | and_notab_c;

    // Generate out_pos using Product-of-Sums (POS) expression
    wire and_c_orNotb_d_orNota_b = c & ((~b) | d) & ((~a) | b);
    wire and_c_orNotb_d_orNota_d = c & ((~b) | d) & ((~a) | d);
    wire pos0 = and_c_orNotb_d_orNota_b;
    wire pos1 = and_c_orNotb_d_orNota_d;
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
