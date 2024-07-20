module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-of-Products (SOP) form for the specified conditions:
    // out_sop = m(2) + m(7) + m(15)
    // where m(i) represents the min-term for the decimal number i.
    assign out_sop = (~a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d);
    
    // Minimum Product-of-Sums (POS) form for the specified conditions:
    // out_pos = M(0)M(1)M(4)M(5)M(6)M(9)M(10)M(13)M(14)
    // where M(i) represents the max-term for the decimal number i.
    assign out_pos = (a | b | c | d) &
                     (a | b | c | ~d) &
                     (a | b | ~c | d) &
                     (a | b | ~c | ~d) &
                     (a | ~b | ~c | d) &
                     (~a | b | c | ~d) &
                     (~a | b | ~c | d) &
                     (~a | ~b | c | ~d) &
                     (~a | ~b | ~c | d);

endmodule
