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

wire [2:0] q_to_u1, q_to_u2, q_to_u3;

top_module u1 (
    .clk(clk),
    .L(L),
    .q_in(q),
    .r_in(r),
    .Q(q_to_u1)
);

top_module u2 (
    .clk(clk),
    .L(L),
    .q_in(q_to_u1),
    .r_in(r),
    .Q(q_to_u2)
);

top_module u3 (
    .clk(clk),
    .L(L),
    .q_in(q_to_u2),
    .r_in(r),
    .Q(q)
);

endmodule
