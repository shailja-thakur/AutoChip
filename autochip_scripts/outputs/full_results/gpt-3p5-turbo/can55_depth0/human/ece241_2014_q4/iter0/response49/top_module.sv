module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire q1, q2, q3;

assign q1 = d1;
assign q2 = d2;
assign q3 = d3;

wire x_xor_q1 = x ^ q1; // XOR gate
wire x_and_not_q2 = x & ~q2; // AND gate
wire x_or_not_q3 = x | ~q3; // OR gate

d_ff ff1 (.d(x_xor_q1), .clk(clk), .q(d1)); // D flip-flop #1
d_ff ff2 (.d(x_and_not_q2), .clk(clk), .q(d2)); // D flip-flop #2
d_ff ff3 (.d(x_or_not_q3), .clk(clk), .q(d3)); // D flip-flop #3

assign z = ~(d1 ^ d2 ^ d3); // XNOR gate

endmodule
module d_ff (
    input d,
    input clk,
    output q
);

reg q;

always @(posedge clk) begin
    q <= d;
end

endmodule
