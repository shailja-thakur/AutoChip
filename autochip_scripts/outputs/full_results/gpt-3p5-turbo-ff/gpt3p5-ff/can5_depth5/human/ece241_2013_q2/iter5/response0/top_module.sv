module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// SOP (Sum-of-Products) form
// The output is 1 when 2, 7, or 15 appears on the inputs
assign out_sop = (a & ~b & ~c & ~d) |
                (~a & ~b & c & d) |
                (~a & b & c & d);

// POS (Product-of-Sums) form
// The output is 0 when 0, 1, 4, 5, 6, 9, 10, 13, or 14 appears on the inputs
assign out_pos = (~a + ~b + ~c + ~d) *
                (~a + ~b + c + ~d) *
                (~a + ~b + c + d) *
                (~a + b + ~c + ~d) *
                (~a + b + ~c + d) *
                (a + ~b + ~c + ~d) *
                (a + ~b + c + ~d) *
                (a + ~b + c + d) *
                (a + b + ~c + ~d) *
                (a + b + ~c + d) *
                (a + b + c + ~d);

endmodule
