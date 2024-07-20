module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Define the output in minimum sum-of-products form
assign out_sop = (a & ~b & ~c & ~d) | // 2
                (~a & b & c & d) | // 7
                (a & b & c & d); // 15

// Define the output in minimum product-of-sums form
wire or1, or2, or3;
assign or1 = ~a | ~b | ~c | ~d; // 0
assign or2 = a | ~b | ~c | ~d; // 1
assign or3 = ~a | b | ~c | ~d; // 4, 5, 6
wire and1, and2;
assign and1 = or1 & or2 & or3; // 0, 1, 4, 5, 6
assign and2 = ~a & ~b & c & d; // 7
assign out_pos = and1 & (~and2); // 0, 1, 4, 5, 6, 9, 10, 13, 14

endmodule
