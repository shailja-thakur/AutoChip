module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux_2to1(
    input S,
    input A,
    input B,
    output reg Y
);

always @(*)
    case (S)
        1'b0: Y <= A;
        1'b1: Y <= B;
    endcase

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire mux_out;
wire [2:0] flipflop_out;

flipflop ff1(
    .clk(clk),
    .D(q_in),
    .Q(flipflop_out[0])
);

flipflop ff2(
    .clk(clk),
    .D(flipflop_out[1]),
    .Q(flipflop_out[2])
);

mux_2to1 mux(
    .S(L),
    .A(r_in),
    .B(flipflop_out[2]),
    .Y(mux_out)
);

always @(posedge clk)
    if (L)
        q <= r_in;
    else
        q <= {q[1] ^ q[2], q[0], mux_out};

assign Q = flipflop_out[0];

endmodule
