module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Compute output in minimized sum-of-products form
    assign out_sop = ( (~a & ~b & c & ~d)  // 2
                       || (~a & b & c & d)   // 7
                       || (a & b & c & d));  // 15

    // Compute output in minimized product-of-sums form
    assign out_pos = ((a | b | c)              // or not 0, ambiguous condition but setting true form
                     && (~a | ~b | c | ~d)     // or not 1
                     && (~a | ~b | ~c | ~d)    // or not 4
                     && (~a | ~b | ~c | c)     // or not 5
                     && (~a | ~d)              // not 6
                     && (d | ~b)               // not 9
                     && (~a | b | d | c)       // not 10
                     && (~a | b | ~c | ~d)      // not 13
                     && (~a | ~b | ~c | ~d));     // not 14

endmodule
