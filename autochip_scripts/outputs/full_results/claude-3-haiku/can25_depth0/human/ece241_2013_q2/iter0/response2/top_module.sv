module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

wire [3:0] inputs = {a, b, c, d};

// out_sop in minimum sum-of-products form
assign out_sop = (inputs == 4'b0010) | (inputs == 4'b0111) | (inputs == 4'b1111);

// out_pos in minimum product-of-sums form
assign out_pos = (~a | ~b | ~c | ~d) & (a | b | ~c | ~d) & (a | ~b | c | ~d) & (a | b | c | ~d);

endmodule
