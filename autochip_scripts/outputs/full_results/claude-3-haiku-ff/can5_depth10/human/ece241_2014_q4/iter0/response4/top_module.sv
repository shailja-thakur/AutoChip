module top_module (
    input clk,
    input x,
    output z
);

wire d1, d2, d3;
wire q1, q2, q3;
wire q1_bar, q2_bar, q3_bar;

// XOR gate
xor(d1, x, q1);

// AND gate
not(q1_bar, q1);
and(d2, x, q1_bar);

// OR gate
not(q2_bar, q2);
or(d3, x, q2_bar);

// D flip-flops
dff ff1 (.clk(clk), .d(d1), .q(q1));
dff ff2 (.clk(clk), .d(d2), .q(q2));
dff ff3 (.clk(clk), .d(d3), .q(q3));

// XNOR gate
xnor(z, q1, q2, q3);

module dff (
    input clk,
    input d,
    output reg q
);

always @(posedge clk) begin
    q <= d;
end

endmodule
