module flipflop (
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2to1 (
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S or D0 or D1) begin
    if (S == 0)
        Y <= D0;
    else
        Y <= D1;
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire D;
wire q_next;

flipflop FF (
    .clk(clk),
    .D(D),
    .Q(Q)
);

mux_2to1 MUX (
    .S(L),
    .D0(q_in),
    .D1(r_in),
    .Y(D)
);

always @(posedge clk) begin
    Q <= q_next;
end

endmodule
