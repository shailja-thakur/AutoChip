module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux_2to1(
    input I0,
    input I1,
    input S,
    output reg O
);

always @(*)
    if (S == 0)
        O <= I0;
    else
        O <= I1;

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire q0, q1, q2;
wire d0, d1, d2;
wire s0, s1, s2;

flipflop ff0(.clk(clk), .D(q0), .Q(q0));
flipflop ff1(.clk(clk), .D(q1), .Q(q1));
flipflop ff2(.clk(clk), .D(q2), .Q(q2));

mux_2to1 mux0(.I0(r_in), .I1(q_in), .S(L), .O(q0));
mux_2to1 mux1(.I0(q1), .I1(q_in), .S(L), .O(q1));
mux_2to1 mux2(.I0(q2), .I1(q_in), .S(L), .O(q2));

always @(posedge clk)
    if (L)
        Q <= r_in;
    else
        Q <= {q1 ^ q2, q0, q2};

endmodule
