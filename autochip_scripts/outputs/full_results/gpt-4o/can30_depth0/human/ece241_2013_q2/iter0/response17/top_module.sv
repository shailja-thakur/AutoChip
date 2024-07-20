module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products (SOP) form for out_sop
    assign out_sop = (~a & ~b & c & ~d) | // 2 = 0010
                     (~a & b & c & d)   | // 7 = 0111
                     (a & b & c & d);     // 15 = 1111

    // Product of Sums (POS) form for out_pos
    assign out_pos = (a | b | ~c | d) &   // corresponds to 0, 1, 4, 5, 6, 9, 10, 13, 14 being logic-0.
                     (a | ~b | ~c | ~d) &
                     (~a | ~b | ~c | ~d);
                     
endmodule
