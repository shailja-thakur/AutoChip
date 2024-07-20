module sub_module(
    input wire clk,
    input wire L,
    input wire d0,
    input wire d1,
    output reg q
);

always @(posedge clk) begin
    if (L)
        q <= d0;
    else
        q <= d1;
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output [2:0] q_out
);

// Internal wires to connect submodules
wire [2:0] mux_out;

sub_module u0 (
    .clk(clk),
    .L(L),
    .d0(r_in[0]),
    .d1(q_out[1] ^ q_out[2]),
    .q(q_out[0])
);

sub_module u1 (
    .clk(clk),
    .L(L),
    .d0(r_in[1]),
    .d1(q_out[0]),
    .q(q_out[1])
);

sub_module u2 (
    .clk(clk),
    .L(L),
    .d0(r_in[2]),
    .d1(q_out[2]),
    .q(q_out[2])
);

endmodule
