module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2to1(
    input S,
    input I0,
    input I1,
    output reg O
);

always @(*) begin
    case(S)
        0: O = I0;
        1: O = I1;
    endcase
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire M0, M1, M2, FF0, FF1, FF2;

mux_2to1 M0 (
    .S(L),
    .I0(r_in),
    .I1(q_in),
    .O(M0)
);

flipflop FF0 (
    .clk(clk),
    .D(M0),
    .Q(FF0)
);

mux_2to1 M1 (
    .S(L),
    .I0(M0),
    .I1(FF0),
    .O(M1)
);

flipflop FF1 (
    .clk(clk),
    .D(M1),
    .Q(FF1)
);

mux_2to1 M2 (
    .S(L),
    .I0(M1),
    .I1(FF1),
    .O(M2)
);

flipflop FF2 (
    .clk(clk),
    .D(M2),
    .Q(Q)
);

endmodule
