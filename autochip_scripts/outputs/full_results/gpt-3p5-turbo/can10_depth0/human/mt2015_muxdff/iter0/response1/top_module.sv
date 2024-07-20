module flipflop(
    input clk,
    input R,
    output reg Q
);

always @(posedge clk)
    Q <= R;

endmodule
module mux2to1(
    input I0,
    input I1,
    input S,
    output reg Y
);

always @(I0, I1, S)
begin
    if (S == 0)
        Y = I0;
    else
        Y = I1;
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;

flipflop ff1 (
    .clk(clk),
    .R(q_in[0]),
    .Q(q[0])
);

flipflop ff2 (
    .clk(clk),
    .R(q_in[1]),
    .Q(q[1])
);

flipflop ff3 (
    .clk(clk),
    .R(q_in[2]),
    .Q(q[2])
);

mux2to1 mux (
    .I0(r_in),
    .I1(q[0]),
    .S(L),
    .Y(Q)
);

endmodule
