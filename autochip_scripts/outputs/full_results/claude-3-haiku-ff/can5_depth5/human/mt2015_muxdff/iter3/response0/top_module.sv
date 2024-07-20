module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

top_module u0 (
    .clk(clk),
    .L(L),
    .q_in({1'b0, q[0]}),
    .r_in({1'b0, r[0]}),
    .Q(q[0])
);

top_module u1 (
    .clk(clk),
    .L(L),
    .q_in({1'b0, q[1]}),
    .r_in({1'b0, r[1]}),
    .Q(q[1])
);

top_module u2 (
    .clk(clk),
    .L(L),
    .q_in({1'b0, q[2]}),
    .r_in({1'b0, r[2]}),
    .Q(q[2])
);

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {Q[1:0], Q[2]};
    end
end

endmodule
