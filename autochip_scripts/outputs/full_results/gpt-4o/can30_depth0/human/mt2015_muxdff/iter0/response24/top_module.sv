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
    wire [2:0] q_int;

    top_module u0 (.clk(clk), .L(L), .q_in(q_int[1] ^ q_int[2]), .r_in(r[0]), .Q(q_int[0]));
    top_module u1 (.clk(clk), .L(L), .q_in(q_int[0]), .r_in(r[1]), .Q(q_int[1]));
    top_module u2 (.clk(clk), .L(L), .q_in(q_int[2]), .r_in(r[2]), .Q(q_int[2]));

    assign q = q_int;
endmodule
