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
    case (S)
        0: Y <= D0;
        1: Y <= D1;
    endcase
end

endmodule
module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire f1_q, f2_q, f3_q;

flipflop f1 (
    .clk(clk),
    .D(q_in),
    .Q(f1_q)
);

flipflop f2 (
    .clk(clk),
    .D(f1_q),
    .Q(f2_q)
);

flipflop f3 (
    .clk(clk),
    .D(f2_q),
    .Q(f3_q)
);

mux2to1 mux (
    .S(L),
    .D0(r_in),
    .D1(f3_q),
    .Y(Q)
);

endmodule
