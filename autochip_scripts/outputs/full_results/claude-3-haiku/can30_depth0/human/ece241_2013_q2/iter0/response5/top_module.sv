module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Implement the sum-of-products form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (a & b & c & ~d) | // 7
                (a & b & c & d); // 15

// Implement the product-of-sums form
wire term1 = ~a | ~b | c | d; // 0, 1, 4, 5, 6, 9, 10, 13, 14
wire term2 = a | ~b | ~c | ~d; // 2
wire term3 = ~a | b | ~c | d; // 7
assign out_pos = (term1) & (term2) & (term3);

endmodule
