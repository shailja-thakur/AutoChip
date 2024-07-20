module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3;
wire q1, q2, q3;

// Filling the D flip-flops
always @(posedge clk) begin
    d1 <= x;
    d2 <= ~q2;
    d3 <= ~q3;
end

// XOR gate
assign q1 = d1 ^ q1;

// AND gate
assign q2 = d2 & ~q2;

// OR gate
assign q3 = d3 | ~q3;

// XNOR gate
assign z = q1 ^ q2 ^ q3;

endmodule
