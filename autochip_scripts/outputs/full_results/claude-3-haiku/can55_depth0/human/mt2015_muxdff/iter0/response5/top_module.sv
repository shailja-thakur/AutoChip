module top_module(
    input clk,
    input L,
    input [2:0] q_in,
    input [2:0] r_in,
    output reg [2:0] Q
);

reg [2:0] q_next;

always @(*) begin
    if (L) begin
        q_next = r_in;
    end else begin
        q_next = {q_in[1] ^ q_in[2], q_in[0], q_in[2]};
    end
end

always @(posedge clk) begin
    Q <= q_next;
end

endmodule
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

top_module top_module_inst1 (
    .clk(clk),
    .L(L),
    .q_in(q),
    .r_in(r),
    .Q(q)
);

top_module top_module_inst2 (
    .clk(clk),
    .L(L),
    .q_in(q),
    .r_in(r),
    .Q(q)
);

top_module top_module_inst3 (
    .clk(clk),
    .L(L),
    .q_in(q),
    .r_in(r),
    .Q(q)
);

endmodule
