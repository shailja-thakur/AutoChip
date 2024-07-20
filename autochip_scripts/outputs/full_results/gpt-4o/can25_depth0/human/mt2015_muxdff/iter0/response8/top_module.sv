module mux2_1(
    input sel,
    input a,
    input b,
    output y
);
    assign y = sel ? b : a;
endmodule
module d_flipflop(
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    input [2:0] q_in,
    output [2:0] Q
);
    wire [2:0] mux_out;
    wire [2:0] d_ff_out;

    // Instantiate 3 2-to-1 multiplexers
    mux2_1 mux0(
        .sel(L),
        .a({q_in[1] ^ q_in[2]}),
        .b(r_in[0]),
        .y(mux_out[0])
    );

    mux2_1 mux1(
        .sel(L),
        .a(q_in[0]),
        .b(r_in[1]),
        .y(mux_out[1])
    );

    mux2_1 mux2(
        .sel(L),
        .a(q_in[2]),
        .b(r_in[2]),
        .y(mux_out[2])
    );

    // Instantiate 3 D flip-flops
    d_flipflop dff0(
        .clk(clk),
        .d(mux_out[0]),
        .q(Q[0])
    );

    d_flipflop dff1(
        .clk(clk),
        .d(mux_out[1]),
        .q(Q[1])
    );

    d_flipflop dff2(
        .clk(clk),
        .d(mux_out[2]),
        .q(Q[2])
    );
endmodule
