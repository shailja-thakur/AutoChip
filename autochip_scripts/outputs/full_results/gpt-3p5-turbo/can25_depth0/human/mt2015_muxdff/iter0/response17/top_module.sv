module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk)
    Q <= D;

endmodule
module mux_2_1(
    input sel,
    input D0,
    input D1,
    output reg Q
);

always @(*)
    case (sel)
        0: Q <= D0;
        1: Q <= D1;
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

    wire [2:0] mux_out1;
    wire [2:0] mux_out2;
    wire [2:0] mux_out3;

    flipflop ff1 (
        .clk(clk),
        .D({q[1] ^ q[2], q[0], q[2]}),
        .Q(q_in)
    );

    mux_2_1 mux1 (
        .sel(L),
        .D0(r_in),
        .D1(q_in),
        .Q(mux_out1)
    );

    mux_2_1 mux2 (
        .sel({q[1], q[2]}),
        .D0(r_in),
        .D1(q_in),
        .Q(mux_out2)
    );

    mux_2_1 mux3 (
        .sel({q[1] ^ q[2], q[0], q[2]}),
        .D0(r_in),
        .D1(q_in),
        .Q(mux_out3)
    );

    always @(posedge clk)
        if (L)
            Q <= r_in;
        else
            Q <= {q[1] ^ q[2], q[0], q[2]};

endmodule
