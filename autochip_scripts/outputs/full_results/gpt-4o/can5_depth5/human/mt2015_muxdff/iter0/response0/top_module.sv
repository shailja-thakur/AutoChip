module flipflop_mux(
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

// Internal wires to hold the intermediate values
wire [2:0] q_internal;

// Instantiate the submodule for each bit
flipflop_mux u0 (
    .clk(clk),
    .L(L),
    .r_in(r[0]),
    .q_in(q[2] ^ q[1]),
    .Q(q_internal[0])
);

flipflop_mux u1 (
    .clk(clk),
    .L(L),
    .r_in(r[1]),
    .q_in(q[0]),
    .Q(q_internal[1])
);

flipflop_mux u2 (
    .clk(clk),
    .L(L),
    .r_in(r[2]),
    .q_in(q[1]),
    .Q(q_internal[2])
);

// Assign the outputs
assign q = q_internal;

endmodule
