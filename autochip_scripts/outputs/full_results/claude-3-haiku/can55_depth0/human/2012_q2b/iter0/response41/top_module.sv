module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Derive the Verilog expressions for Y1 and Y3 based on the given state machine diagram and one-hot encoding

// Expression for Y1
assign Y1 = (y[0] & w) | (y[1] & ~w) | (y[3] & w) | (y[5] & ~w);

// Expression for Y3
assign Y3 = (y[1] & w) | (y[2] & ~w) | (y[3] & w) | (y[5] & ~w);

endmodule
