module flipflop_mux (
    input clk,
    input L,
    input r_in,
    input q_in,
    output reg q_out
);

always @(posedge clk) begin
    if (L) begin
        q_out <= r_in;
    end else begin
        q_out <= q_in;  // This will be connected to xor of q[1] and q[2]
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire q1, q2, q0;

// Instantiate three submodules
flipflop_mux submodule0 (
    .clk(clk),
    .L(L),
    .r_in(r[0]),
    .q_in(q1 ^ q2),
    .q_out(q[0])
);

flipflop_mux submodule1 (
    .clk(clk),
    .L(L),
    .r_in(r[1]),
    .q_in(q[0]),
    .q_out(q[1])
);

flipflop_mux submodule2 (
    .clk(clk),
    .L(L),
    .r_in(r[2]),
    .q_in(q2),
    .q_out(q[2])
);

assign q1 = q[1];
assign q2 = q[2];

endmodule
