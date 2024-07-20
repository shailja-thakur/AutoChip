module top_module(
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
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

reg [2:0] q_reg;
wire [2:0] q_next;

top_module u0 (.clk(clk), .L(L), .q_in(q_reg[1] ^ q_reg[2]), .r_in(r[0]), .Q(q_next[0]));
top_module u1 (.clk(clk), .L(L), .q_in(q_reg[0] ^ q_reg[1]), .r_in(r[1]), .Q(q_next[1]));
top_module u2 (.clk(clk), .L(L), .q_in(q_reg[2] ^ q_reg[0]), .r_in(r[2]), .Q(q_next[2]));

always @(posedge clk) begin
    q_reg <= q_next;
end

assign q = q_reg;

endmodule
