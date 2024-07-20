module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) logic
    wire and_cd = c & d;
    wire and_not_a_not_b_c = ~a & ~b & c;
    assign out_sop = and_cd | and_not_a_not_b_c;

    // Product-of-Sums (POS) logic
    wire pos0, pos1;

    // Intermediate ANDs for POS
    wire or_not_b_d = ~b | d;
    wire or_not_a_b = ~a | b;
    wire or_not_a_d = ~a | d;

    assign pos0 = c & or_not_b_d & or_not_a_b;
    assign pos1 = c & or_not_b_d & or_not_a_d;

    // Assign out_pos based on ternary condition
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
    
endmodule
