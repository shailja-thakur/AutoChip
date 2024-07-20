module flipflop (
    input clk,
    input D,
    input reset,
    output reg Q
);


always @(posedge clk or posedge reset)
begin
    if(reset)
        Q <= 1'b0;
    else
        Q <= D;
end


endmodule
module mux_2_1 (
    input I0,
    input I1,
    input S,
    output reg O
);


always @(*)
begin
    if(S)
        O = I1;
    else
        O = I0;
end


endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);


wire q1, q2;

flipflop ff1(
    .clk(clk),
    .D(q_in),
    .reset(L),
    .Q(q1)
);


flipflop ff2(
    .clk(clk),
    .D(q1),
    .reset(L),
    .Q(q2)
);


flipflop ff3(
    .clk(clk),
    .D(q2),
    .reset(L),
    .Q(Q)
);


mux_2_1 mux1(
    .I0(r_in),
    .I1(q2),
    .S(L),
    .O(q_in)
);


endmodule
