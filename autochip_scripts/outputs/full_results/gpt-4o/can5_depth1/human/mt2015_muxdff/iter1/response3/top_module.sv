module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

wire [2:0] q_internal;

top_module inst0 (
    .clk(clk),
    .L(L),
    .q_in(q[1] ^ q[2]),
    .r_in(r[0]),
    .Q(q_internal[0])
);

top_module inst1 (
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[1]),
    .Q(q_internal[1])
);

top_module inst2 (
    .clk(clk),
    .L(L),
    .q_in(q[1]),
    .r_in(r[2]),
    .Q(q_internal[2])
);

always @(posedge clk) begin
    q <= q_internal;
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
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
