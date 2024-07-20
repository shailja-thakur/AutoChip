module multiplexer(
    input select,
    input [2:0] data0,
    input [2:0] data1,
    output [2:0] out
);
    assign out = select ? data1 : data0;
endmodule
module flipflop(
    input clk,
    input [2:0] d,
    output reg [2:0] q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module submodule(
    input clk,
    input L,
    input [2:0] r,
    input [2:0] q_in,
    output [2:0] q
);
    wire [2:0] mux_out;

    multiplexer m1(
        .select(L),
        .data0({q_in[1] ^ q_in[2], q_in[0], q_in[2]}),
        .data1(r),
        .out(mux_out)
    );

    flipflop ff1(
        .clk(clk),
        .d(mux_out),
        .q(q)
    );
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);
    wire [2:0] q_internal_1, q_internal_2;

    submodule u1(
        .clk(clk),
        .L(L),
        .r(r),
        .q_in(3'b000),
        .q(q_internal_1)
    );

    submodule u2(
        .clk(clk),
        .L(L),
        .r(q_internal_1),
        .q_in(q_internal_1),
        .q(q_internal_2)
    );

    submodule u3(
        .clk(clk),
        .L(L),
        .r(q_internal_2),
        .q_in(q_internal_2),
        .q(q)
    );
endmodule
