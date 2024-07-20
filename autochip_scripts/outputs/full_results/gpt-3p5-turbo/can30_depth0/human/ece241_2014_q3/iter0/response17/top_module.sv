module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

// Intermediate signals
wire w1, w2, w3, w4, w5;

// Assign intermediate signals
assign w1 = c & (~d);
assign w2 = ~c & ~d;
assign w3 = ~c & d;
assign w4 = c & d;
assign w5 = a & b;

// Create 4-to-1 multiplexer
mux4to1 mux (
    .a(w1),
    .b(w2),
    .c(w3),
    .d(w4),
    .ab(w5),
    .output(mux_in)
);

endmodule
module mux4to1 (
    input a,
    input b,
    input c,
    input d,
    input [1:0] ab,
    output [3:0] output
);

// Intermediate signals
wire w1, w2, w3, w4;

// Assign intermediate signals
assign w1 = a & (~b) & (~ab[1]) & (~ab[0]);
assign w2 = b & (~c) & (~ab[1]) & ab[0];
assign w3 = c & (~d) & ab[1] & ab[0];
assign w4 = d & ab[1] & (~ab[0]);

// Output assignment
assign output[0] = w1 | w2 | w3 | w4;

endmodule
