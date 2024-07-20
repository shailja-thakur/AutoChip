module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and_cd;
    wire and_nab_c;
    wire n_a, n_b;
    wire pos0, pos1;

    // Calculate NOTs
    assign n_a = ~a;
    assign n_b = ~b;

    // Sum-of-Products (SOP) expression
    assign and_cd = c & d;
    assign and_nab_c = n_a & n_b & c;
    assign out_sop = and_cd | and_nab_c;

    // Product-of-Sums (POS) expression
    assign pos0 = c & (n_b | d) & (n_a | b);
    assign pos1 = c & (n_b | d) & (n_a | d);
    
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
