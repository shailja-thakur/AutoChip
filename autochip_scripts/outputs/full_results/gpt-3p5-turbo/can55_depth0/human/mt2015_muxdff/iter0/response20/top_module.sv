module flipflop(
    input clk,
    input D,
    input reset,
    output reg Q
);

always @(posedge clk or posedge reset)
    if (reset)
        Q <= 1'b0;
    else
        Q <= D;

endmodule
module mux_2to1(
    input I0,
    input I1,
    input S,
    output reg Y
);

always @(I0, I1, S)
    if (S)
        Y <= I1;
    else
        Y <= I0;

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] q;
wire [2:0] r;

assign r = r_in;
assign q_in = q;

flipflop FF0 (.clk(clk), .D(q[2]), .reset(L), .Q(q[2]));
flipflop FF1 (.clk(clk), .D(q[0]), .reset(L), .Q(q[0]));
flipflop FF2 (.clk(clk), .D(q[1]), .reset(L), .Q(q[1]));

mux_2to1 M1 (.I0(q[1]), .I1(q[2]), .S(L), .Y(Q));

endmodule
