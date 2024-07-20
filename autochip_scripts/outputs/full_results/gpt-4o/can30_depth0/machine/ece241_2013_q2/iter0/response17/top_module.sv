module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and_cd;
    wire and_notabc;
    wire or1_result;
    wire and_c_orb;
    wire and_final;
    wire or_notab;
    wire or_notad;
    wire pos0;
    wire pos1;

    // SOP calculation
    assign and_cd = c & d;
    assign and_notabc = (~a) & (~b) & c;
    assign out_sop = and_cd | and_notabc;

    // POS calculation
    assign or_notab = (~a) | b;
    assign or_notad = (~a) | d;
    assign pos0 = c & ((~b) | d) & or_notab;
    assign pos1 = c & ((~b) | d) & or_notad;

    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
