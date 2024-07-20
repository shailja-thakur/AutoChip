module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux(
    input [1:0] sel,
    input D0,
    input D1,
    output reg Q
);

always @*
    case (sel)
        2'b00: Q = D0;
        2'b01: Q = D1;
        default: Q = 1'bx;
    endcase

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire [2:0] q_out;

flipflop ff1(
    .clk(clk),
    .D(q_in),
    .Q(q_out[0])
);

flipflop ff2(
    .clk(clk),
    .D(q_out[1]),
    .Q(q_out[2])
);

mux mux1(
    .sel({ff2.Q, L}),
    .D0(r_in),
    .D1(q_out[2:0]),
    .Q(Q)
);

endmodule
