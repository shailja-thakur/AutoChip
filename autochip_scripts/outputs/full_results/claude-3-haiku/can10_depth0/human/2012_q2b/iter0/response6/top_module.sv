module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

wire A = y[0];
wire B = y[1];
wire C = y[2];
wire D = y[3];
wire E = y[4];
wire F = y[5];

// Y1 signal
assign Y1 = (A & w) | (B & ~w) | (D & ~w) | (E & w);

// Y3 signal
assign Y3 = (B & w) | (C & ~w) | (D & w) | (F & w);

endmodule
