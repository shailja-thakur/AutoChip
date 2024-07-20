module top_module(
    input x,
    input y,
    output z
);

wire a;
wire b;

assign a = x & ~y;
assign b = ~x & y;
assign z = a | b;

endmodule
