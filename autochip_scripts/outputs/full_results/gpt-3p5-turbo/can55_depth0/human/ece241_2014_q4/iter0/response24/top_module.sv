module top_module (
	input clk,
	input x,
	output z
);

    reg d1, d2, d3;
    wire q1, q2, q3;
    
    xor_gate xor1 (.a(x), .b(q1), .z(d1));
    and_gate and1 (.a(x), .b(~q2), .z(d2));
    or_gate or1 (.a(x), .b(~q3), .z(d3));
    
    d_flipflop dff1 (.clk(clk), .d(d1), .q(q1));
    d_flipflop dff2 (.clk(clk), .d(d2), .q(q2));
    d_flipflop dff3 (.clk(clk), .d(d3), .q(q3));
    
    xnor_gate xnor1 (.a(q1), .b(q2), .c(q3), .z(z));
    
endmodule
