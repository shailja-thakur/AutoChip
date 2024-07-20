module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] Q
);

reg [2:0] r;

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {Q[1] ^ Q[2], Q[0], Q[2]};
    end
end

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

wire [2:0] q1, q2, q3;

top_module u1 (
    .clk(clk),
    .L(L),
    .r_in(r),
    .Q(q1)
);

top_module u2 (
    .clk(clk),
    .L(L),
    .r_in(r),
    .Q(q2)
);

top_module u3 (
    .clk(clk),
    .L(L),
    .r_in(r),
    .Q(q3)
);

always @(*) begin
    q = {q1[0], q2[1], q3[2]};
end

endmodule
