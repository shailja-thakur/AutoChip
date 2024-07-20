module flipflop(
    input clk,
    input reset_n, // added reset signal
    input D,
    output reg Q
);

always @(posedge clk or negedge reset_n) begin
    if (~reset_n)
        Q <= 0;
    else
        Q <= D;
end

endmodule
module mux_2to1(
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S or D0 or D1) begin
    if (S)
        Y <= D1;
    else
        Y <= D0;
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire q1, q2, q3; // added wire connections

flipflop ff1(
    .clk(clk),
    .reset_n(1), // assuming active-low reset
    .D(r_in),
    .Q(q1)
);

flipflop ff2(
    .clk(clk),
    .reset_n(1), // assuming active-low reset
    .D(q_in),
    .Q(q2)
);

flipflop ff3(
    .clk(clk),
    .reset_n(1), // assuming active-low reset
    .D(q2),
    .Q(q3)
);

mux_2to1 mux(
    .S(L),
    .D0(q1),
    .D1(q3),
    .Y(Q)
);

endmodule
