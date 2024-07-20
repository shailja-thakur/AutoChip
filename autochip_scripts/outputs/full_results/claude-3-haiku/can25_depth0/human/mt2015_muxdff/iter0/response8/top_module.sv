module top_module(
    input clk,
    input L,
    input [2:0] r,
    output reg [2:0] q
);

wire [2:0] q_int;

submodule U1 (.clk(clk), .L(L), .q_in(q[0]), .r_in(r[0]), .Q(q_int[0]));
submodule U2 (.clk(clk), .L(L), .q_in(q[1]), .r_in(r[1]), .Q(q_int[1]));
submodule U3 (.clk(clk), .L(L), .q_in(q[2]), .r_in(r[2]), .Q(q_int[2]));

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q_int[1] ^ q_int[2], q_int[0], q_int[2]};
    end
end

endmodule
module submodule(
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
