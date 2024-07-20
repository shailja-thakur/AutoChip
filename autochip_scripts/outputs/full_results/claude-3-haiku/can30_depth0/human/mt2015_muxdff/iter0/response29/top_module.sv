module top_module(
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

wire [2:0] q_intermediate;

sub_module sub_module_1 (
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[0]),
    .Q(q_intermediate[0])
);

sub_module sub_module_2 (
    .clk(clk),
    .L(L),
    .q_in(q[1]),
    .r_in(r[1]),
    .Q(q_intermediate[1])
);

sub_module sub_module_3 (
    .clk(clk),
    .L(L),
    .q_in(q[2]),
    .r_in(r[2]),
    .Q(q_intermediate[2])
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q_intermediate[1] ^ q_intermediate[2], q_intermediate[0], q_intermediate[2]};
    end
end

endmodule
module sub_module(
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
