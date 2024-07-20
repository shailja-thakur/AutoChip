module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux(
    input S,
    input D0,
    input D1,
    output reg Q
);

always @(*)
    if (S == 0)
        Q = D0;
    else
        Q = D1;

endmodule
module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q
);

wire q0, q1, q2;

flipflop ff0(
    .clk(clk),
    .D(q_in),
    .Q(q0)
);

flipflop ff1(
    .clk(clk),
    .D(q0),
    .Q(q1)
);

mux mux0(
    .S(L),
    .D0(r_in),
    .D1(q1),
    .Q(Q)
);

endmodule
