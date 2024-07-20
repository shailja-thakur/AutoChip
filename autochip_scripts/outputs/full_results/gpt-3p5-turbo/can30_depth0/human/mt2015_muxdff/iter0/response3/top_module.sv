module flipflop (
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux2to1 (
    input S,
    input D0,
    input D1,
    output reg Y
);

always @(S or D0 or D1) begin
    if (S == 0) begin
        Y <= D0;
    end else begin
        Y <= D1;
    end
end

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire q1, q2, q3;
wire mux_sel1, mux_sel2;

flipflop FF1 (
    .clk(clk),
    .D(q_in),
    .Q(q1)
);

flipflop FF2 (
    .clk(clk),
    .D(q1),
    .Q(q2)
);

flipflop FF3 (
    .clk(clk),
    .D(q2),
    .Q(q3)
);

mux2to1 MUX1 (
    .S(L),
    .D0(r_in),
    .D1(q3),
    .Y(Q)
);

endmodule
