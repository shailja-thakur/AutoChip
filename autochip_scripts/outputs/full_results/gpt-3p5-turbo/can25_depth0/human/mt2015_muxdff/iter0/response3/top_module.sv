module submodule (
    input clk,
    input L,
    input [2:0] r,
    output reg [2:0] q
);

reg [2:0] q_temp;

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q_temp <= {q[1] ^ q[2], q[0], q[2]};
        q <= q_temp;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;

submodule u1 (
    .clk(clk),
    .L(L),
    .r(r_in),
    .q(q[0])
);

submodule u2 (
    .clk(clk),
    .L(L),
    .r(r_in),
    .q(q[1])
);

submodule u3 (
    .clk(clk),
    .L(L),
    .r(r_in),
    .q(q[2])
);

always @* begin
    Q = q_in;
end

endmodule
