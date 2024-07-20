module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);

always @(posedge clk) begin
    if (L)
        Q <= r_in;
    else
        Q <= q_in;
end

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

top_module u0(
    .clk(clk),
    .L(L),
    .q_in(q),
    .r_in(r),
    .Q(q)
);

endmodule
