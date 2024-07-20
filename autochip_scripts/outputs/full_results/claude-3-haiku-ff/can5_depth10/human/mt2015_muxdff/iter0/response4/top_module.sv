module top_module(
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

wire [2:0] q_int;

top_module_sub sub0 (
    .clk(clk),
    .L(L),
    .q_in(q_int[0]),
    .r_in(r[0]),
    .Q(q_int[0])
);

top_module_sub sub1 (
    .clk(clk),
    .L(L),
    .q_in(q_int[1]),
    .r_in(r[1]),
    .Q(q_int[1])
);

top_module_sub sub2 (
    .clk(clk),
    .L(L),
    .q_in(q_int[2]),
    .r_in(r[2]),
    .Q(q_int[2])
);

assign q = q_int;

endmodule
module top_module_sub(
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
