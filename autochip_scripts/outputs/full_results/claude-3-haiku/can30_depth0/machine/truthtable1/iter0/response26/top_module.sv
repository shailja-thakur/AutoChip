module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

wire a, b, c, d;

// (not x3 and x2 and not x1)
assign a = ~x3 & x2 & ~x1;

// (not x3 and x2 and x1)
assign b = ~x3 & x2 & x1;

// (x3 and not x2 and x1)
assign c = x3 & ~x2 & x1;

// (x3 and x2 and x1)
assign d = x3 & x2 & x1;

// The output f is the logical OR of the four conditions
assign f = a | b | c | d;

endmodule
