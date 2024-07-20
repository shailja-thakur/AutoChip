module top_module(
    input a,
    input b,
    input c,
    input d,
    output q
);

// Intermediate signals for better readability
wire not_a = ~a;
wire not_b = ~b;
wire not_c = ~c;
wire not_d = ~d;

// Combinational circuit logic
assign q = (not_a & not_b & not_c & d) |
           (not_a & not_b & c) |
           (not_a & b & not_c) |
           (not_a & b & c & not_d) |
           (a & b & not_c) |
           (a & b & c);

endmodule
