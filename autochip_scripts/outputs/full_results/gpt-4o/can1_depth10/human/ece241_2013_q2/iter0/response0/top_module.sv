module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) form for generating out_sop
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     ( a & b & c & ~d)  | // 7
                     ( a & b & c &  d);   // 15

    // Product-of-Sums (POS) form for generating out_pos
    assign out_pos = (a | b | ~c | d) & // 2
                     (a | ~b | ~c | d) & // versions of 7 and 15 as different products
                     (~a | b | ~c | d);  // 7, 2
         
endmodule
