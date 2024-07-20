module flop(
    input clk,
    input d,
    output reg q
);

    always @(posedge clk)
        q <= d;

endmodule
module top_module (
    input clk,
    input x,
    output z
);

    reg flop1;
    reg flop2;
    reg flop3;

    wire x1 = flop1 ^ flop2 ^ flop3;
    wire x2 = flop1;
    wire x3 = ~flop2;
    wire x4 = ~flop3;

    flop u1(.clk(clk), .d(x1), .q(flop1));
    flop u2(.clk(clk), .d(x3), .q(flop2));
    flop u3(.clk(clk), .d(x4), .q(flop3));

    assign z = ~(x2 ^ x3 ^ x4);

endmodule
