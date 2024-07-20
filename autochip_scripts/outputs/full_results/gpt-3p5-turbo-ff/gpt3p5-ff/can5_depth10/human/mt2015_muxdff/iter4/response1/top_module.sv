module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

wire mux_out;
wire flipflop_out;

mux_2to1 mux_inst (
    .S(L),
    .I0(q_in),
    .I1(r_in),
    .O(mux_out)
);

flipflop flipflop_inst (
    .clk(clk),
    .D(mux_out),
    .reset(1'b0),
    .Q(flipflop_out)
);

assign Q = flipflop_out;

endmodule
