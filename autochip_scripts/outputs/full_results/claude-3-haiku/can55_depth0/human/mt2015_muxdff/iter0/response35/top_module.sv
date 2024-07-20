module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] q
);

wire [2:0] q_int;

flipflop_mux u0 (.clk(clk), .L(L), .q_in(q_int[0]), .r_in(r_in[0]), .Q(q[0]));
flipflop_mux u1 (.clk(clk), .L(L), .q_in(q_int[1]), .r_in(r_in[1]), .Q(q[1]));
flipflop_mux u2 (.clk(clk), .L(L), .q_in(q_int[2]), .r_in(r_in[2]), .Q(q[2]));

always @(*) begin
    if (L) begin
        q_int <= r_in;
    end else begin
        q_int <= {q[1] ^ q[2], q[0], q[2]};
    end
end

endmodule
module flipflop_mux(
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
