module mux_2to1 (
    input sel,
    input d0,
    input d1,
    output y
);
    assign y = sel ? d1 : d0;
endmodule
module flipflop (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    input q_in,
    output [2:0] Q
);
    wire [2:0] q_intermediate;
    wire [2:0] mux_output;

    mux_2to1 mux0 (
        .sel(L),
        .d0(q_in),
        .d1(r[0]),
        .y(mux_output[0])
    );

    mux_2to1 mux1 (
        .sel(L),
        .d0(q_intermediate[0]),
        .d1(r[1]),
        .y(mux_output[1])
    );

    mux_2to1 mux2 (
        .sel(L),
        .d0(q_intermediate[2]),
        .d1(r[2]),
        .y(mux_output[2])
    );

    flipflop ff0 (
        .clk(clk),
        .d(mux_output[0]),
        .q(q_intermediate[0])
    );

    flipflop ff1 (
        .clk(clk),
        .d(mux_output[1]),
        .q(q_intermediate[1])
    );

    flipflop ff2 (
        .clk(clk),
        .d(mux_output[2]),
        .q(q_intermediate[2])
    );

    assign Q = q_intermediate;

endmodule
