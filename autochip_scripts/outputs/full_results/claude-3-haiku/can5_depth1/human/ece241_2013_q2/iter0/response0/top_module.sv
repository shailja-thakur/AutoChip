module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Out_sop in minimum sum-of-products form
assign out_sop = (a & ~b & ~c & d) | (~a & b & c & d) | (a & b & c & d);

// Out_pos in minimum product-of-sums form
wire n1, n2, n3;
assign n1 = ~a | ~b | ~c | ~d;
assign n2 = a | ~b | ~c | d;
assign n3 = ~a | b | c | ~d;
assign out_pos = n1 & n2 & n3;

endmodule
