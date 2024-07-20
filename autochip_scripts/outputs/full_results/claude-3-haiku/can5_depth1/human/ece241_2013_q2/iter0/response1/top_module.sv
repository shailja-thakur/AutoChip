module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Sum-of-products form
assign out_sop = (~a & ~b & ~c & ~d) | // 0
                (~a & ~b & c & d) | // 7
                (a & b & c & d); // 15

// Product-of-sums form
assign out_pos = (a | b | ~c | ~d) & // Not 2, 7, 15
                (a | ~b | ~c | ~d) & // Not 2, 7, 15
                (~a | b | ~c | ~d) & // Not 2, 7, 15
                (~a | ~b | c | d); // Not 2, 7, 15
endmodule
