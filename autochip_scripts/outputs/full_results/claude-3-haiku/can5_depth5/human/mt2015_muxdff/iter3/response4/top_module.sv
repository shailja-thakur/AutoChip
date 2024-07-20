module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

top_module top_module_0 (
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[0]),
    .Q(q[0])
);

top_module top_module_1 (
    .clk(clk),
    .L(L),
    .q_in(q[1]),
    .r_in(r[1]),
    .Q(q[1])
);

top_module top_module_2 (
    .clk(clk),
    .L(L),
    .q_in(q[2]),
    .r_in(r[2]),
    .Q(q[2])
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1:0], q[2]};
    end
end

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
        Q <= q_in;
    end
end

endmodule
