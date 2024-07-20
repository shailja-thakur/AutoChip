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
    assign out_pos = ((a | b | c | d)       // or 0 
                      && (a | b | ~c | d)   // or 1
                      && (a | b | c | ~d)   // or 4
                      && (a | b | ~c | ~d)  // or 5
                      && (a | ~b | c | d)   // or 6
                      && (a | ~b | c | ~d)  // or 9
                      && (a | ~b | ~c | d)  // or 10
                      && (~a | b | c | d)   // or 13
                      && (~a | b | c | ~d)); // or 14

endmodule
