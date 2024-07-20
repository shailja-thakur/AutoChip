module mux_ff(
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire [2:0] mux_out;

// Instantiate three instances of mux_ff
mux_ff u0 (
    .clk(clk),
    .L(L),
    .r_in(r[0]),
    .q_in(q[0]),
    .Q(mux_out[0])
);

mux_ff u1 (
    .clk(clk),
    .L(L),
    .r_in(r[1]),
    .q_in(q[1]),
    .Q(mux_out[1])
);

mux_ff u2 (
    .clk(clk),
    .L(L),
    .r_in(r[2]),
    .q_in(q[2]),
    .Q(mux_out[2])
);

// Assign the multiplexer outputs to q
assign q = mux_out;

endmodule
