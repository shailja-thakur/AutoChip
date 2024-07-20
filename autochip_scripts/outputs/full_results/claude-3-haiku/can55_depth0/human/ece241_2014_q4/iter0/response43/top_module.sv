module top_module (
    input clk,
    input x,
    output z
);

wire d1, d2, d3;
wire q1, q2, q3;
wire q1_not, q2_not, q3_not;

// D Flip-Flops
always @(posedge clk) begin
    q1 <= d1;
    q2 <= d2;
    q3 <= d3;
end

// XOR, AND, OR gates
assign d1 = x ^ q1;
assign d2 = x & q2_not;
assign d3 = x | q3_not;

// Complemented outputs
assign q1_not = ~q1;
assign q2_not = ~q2;
assign q3_not = ~q3;

// 3-input XNOR
assign z = ~(q1 ^ q2 ^ q3);

endmodule
