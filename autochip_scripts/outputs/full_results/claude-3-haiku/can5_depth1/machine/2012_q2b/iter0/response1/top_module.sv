module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

// Implement the combinational logic circuit

// Y1 = y[0] AND w
assign Y1 = y[0] & w;

// Y3 = (y[1] OR y[2] OR y[4] OR y[5]) AND (NOT w)
wire y_or = y[1] | y[2] | y[4] | y[5];
assign Y3 = y_or & ~w;

endmodule
