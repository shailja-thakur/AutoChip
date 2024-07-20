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
    input D0,
    input D1,
    output reg Y
);

    always @(*) begin
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

    wire q_internal;
    wire [2:0] r_internal;

    flipflop flipflop_inst1(
        .clk(clk),
        .D(q_internal),
        .Q(Q)
    );

    mux_2to1 mux_inst1(
        .S(L),
        .D0(r_internal),
        .D1(q_internal),
        .Y(q_internal)
    );

    flipflop flipflop_inst2(
        .clk(clk),
        .D(q_internal),
        .Q(q_internal)
    );

    mux_2to1 mux_inst2(
        .S(L),
        .D0(q_internal),
        .D1(r_internal),
        .Y(r_internal)
    );

    flipflop flipflop_inst3(
        .clk(clk),
        .D(Q),
        .Q(q_internal)
    );

    mux_2to1 mux_inst3(
        .S(L),
        .D0(q_internal),
        .D1(r_internal),
        .Y(Q)
    );

endmodule
