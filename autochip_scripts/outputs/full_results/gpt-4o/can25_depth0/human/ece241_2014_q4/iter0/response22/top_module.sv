module top_module (
	input clk,
	input x,
	output z
);

// D flip-flop outputs
reg q1, q2, q3;
	
// D flip-flop next state and complemented outputs
wire d1, d2, d3;
wire q2_not, q3_not;
	
// Gates logic
assign d1 = x ^ q1;              // XOR gate
assign d2 = x & ~q2;             // AND gate, with complemented output of flip-flop
assign d3 = x | ~q3;             // OR gate, with complemented output of flip-flop

// Flip-flops with synchronous reset
always @(posedge clk) begin
	q1 <= d1;
	q2 <= d2;
	q3 <= d3;
end
	
// Three-input XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

endmodule
