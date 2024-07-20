module flipflop_mux (
    input clk,
    input L,
    input D,
    input r,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r;
    end else begin
        Q <= D;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire q_in0, q_in1;

flipflop_mux ffm0 (
    .clk(clk),
    .L(L),
    .D(q[1] ^ q[2]),
    .r(r[0]),
    .Q(q[0])
);

flipflop_mux ffm1 (
    .clk(clk),
    .L(L),
    .D(q[0]),
    .r(r[1]),
    .Q(q[1])
);

flipflop_mux ffm2 (
    .clk(clk),
    .L(L),
    .D(q[2]),
    .r(r[2]),
    .Q(q[2])
);

endmodule
