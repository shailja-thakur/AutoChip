module flipflop_mux (
    input clk,
    input L,
    input in_data,
    input r,
    output reg q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= in_data;
    end
end

endmodule
module top_module (
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire [2:0] q_tmp;

flipflop_mux u1 (
    .clk(clk),
    .L(L),
    .in_data(q[1] ^ q[2]),
    .r(r[0]),
    .q(q_tmp[0])
);

flipflop_mux u2 (
    .clk(clk),
    .L(L),
    .in_data(q[0]),
    .r(r[1]),
    .q(q_tmp[1])
);

flipflop_mux u3 (
    .clk(clk),
    .L(L),
    .in_data(q[2]),
    .r(r[2]),
    .q(q_tmp[2])
);

assign q = q_tmp;

endmodule
