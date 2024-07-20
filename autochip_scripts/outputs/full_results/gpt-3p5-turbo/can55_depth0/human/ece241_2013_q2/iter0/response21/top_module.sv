module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// Define intermediate signals for each input combination
wire w_0 = (a == 0) && (b == 0) && (c == 0) && (d == 0);
wire w_1 = (a == 0) && (b == 0) && (c == 0) && (d == 1);
wire w_2 = (a == 0) && (b == 0) && (c == 1) && (d == 0);
wire w_4 = (a == 0) && (b == 1) && (c == 0) && (d == 0);
wire w_5 = (a == 0) && (b == 1) && (c == 0) && (d == 1);
wire w_6 = (a == 0) && (b == 1) && (c == 1) && (d == 0);
wire w_7 = (a == 0) && (b == 1) && (c == 1) && (d == 1);
wire w_9 = (a == 1) && (b == 0) && (c == 0) && (d == 1);
wire w_10 = (a == 1) && (b == 0) && (c == 1) && (d == 0);
wire w_13 = (a == 1) && (b == 1) && (c == 0) && (d == 1);
wire w_14 = (a == 1) && (b == 1) && (c == 1) && (d == 0);
wire w_15 = (a == 1) && (b == 1) && (c == 1) && (d == 1);

// Define output out_sop in minimum sum-of-products form
assign out_sop = w_2 || w_7 || w_15;

// Define output out_pos in minimum product-of-sums form
assign out_pos = w_0 && w_1 && w_4 && w_5 && w_6 && w_9 && w_10 && w_13 && w_14;

endmodule
