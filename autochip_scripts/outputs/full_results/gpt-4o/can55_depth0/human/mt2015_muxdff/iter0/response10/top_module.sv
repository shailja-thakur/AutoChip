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

wire [2:0] d; // intermediate wires for the state feedback

flipflop_mux ff0(
    .clk(clk),
    .L(L),
    .r_in(r[0]),
    .q_in(d[0]),
    .Q(q[0])
);

flipflop_mux ff1(
    .clk(clk),
    .L(L),
    .r_in(r[1]),
    .q_in(d[1]),
    .Q(q[1])
);

flipflop_mux ff2(
    .clk(clk),
    .L(L),
    .r_in(r[2]),
    .q_in(d[2]),
    .Q(q[2])
);

// Define feedback connections
assign d[0] = q[1] ^ q[2];
assign d[1] = q[0];
assign d[2] = q[2];

endmodule
