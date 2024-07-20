module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux_2_to_1(
    input [1:0] S,
    input D0,
    input D1,
    output reg Y
);

always @(S,D0,D1) begin
    case(S)
        2'b00: Y <= D0;
        2'b01: Y <= D1;
        2'b10: Y <= 0;
        2'b11: Y <= 1;
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

wire q0, q1, q2;

flipflop ff0 (
    .clk(clk),
    .D(q_in),
    .Q(q0)
);

flipflop ff1 (
    .clk(clk),
    .D(q_in),
    .Q(q1)
);

flipflop ff2 (
    .clk(clk),
    .D(q_in),
    .Q(q2)
);

mux_2_to_1 mux (
    .S({L, q1}),
    .D0(q0),
    .D1(r_in),
    .Y(Q)
);

endmodule
