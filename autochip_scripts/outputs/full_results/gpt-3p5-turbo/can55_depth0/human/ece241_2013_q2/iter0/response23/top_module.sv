module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Determine the output out_sop in minimum sum-of-products form
// The output out_sop is logic-1 when 2, 7, or 15 appears on the inputs

assign out_sop = (a & ~b & ~c & ~d) | // for 2
                (~a & b & c & d) |  // for 7
                (~a & ~b & ~c & ~d);  // for 15

// Determine the output out_pos in minimum product-of-sums form
// The output out_pos is logic-0 when 0, 1, 4, 5, 6, 9, 10, 13, or 14 appears on the inputs

assign out_pos = (~a & ~b & ~c & ~d) & // for 0
                (~a & ~b & ~c & d) &  // for 1
                (~a & b & ~c & d) &   // for 4
                (a & ~b & c & d) &    // for 5
                (~a & b & c & ~d) &   // for 6
                (a & ~b & c & ~d) &   // for 9
                (~a & b & ~c & ~d) &  // for 10
                (a & ~b & ~c & ~d) &  // for 13
                (~a & ~b & c & d);    // for 14

endmodule
