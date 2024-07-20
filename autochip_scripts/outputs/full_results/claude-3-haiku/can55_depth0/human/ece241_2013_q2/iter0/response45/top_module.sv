module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Minimum Sum-of-Products (SOP) form
assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (~a & ~b & c & ~d) | // 4
                (~a & ~b & ~c & d) | // 5
                (~a & ~b & ~c & ~d) | // 6
                (a & b & c & d); // 15

// Minimum Product-of-Sums (POS) form
wire term1 = ~a | ~b;
wire term2 = ~b | ~c;
wire term3 = ~c | ~d;
assign out_pos = (term1 & term2 & ~d) | // 0, 1, 4, 5, 6
                (a & b & c & ~d) | // 7
                (term1 & term2 & term3); // 9, 10, 13, 14
endmodule
