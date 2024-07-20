module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Deriving the Verilog expressions for Y1 and Y3 by inspection
// using the one-hot state encoding provided

// Y1 = y[0] & w + y[1] & !w + y[3] & !w
assign Y1 = y[0] & w | y[1] & ~w | y[3] & ~w;

// Y3 = y[1] & w + y[2] & !w + y[3] & w + y[5] & !w
assign Y3 = y[1] & w | y[2] & ~w | y[3] & w | y[5] & ~w;

endmodule
