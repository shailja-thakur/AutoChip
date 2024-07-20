module top_module (
	input clk,
	input x,
	output z
);
// flip-flops
reg d1, d2, d3;
reg q1, q2, q3;
wire qx1, qx2, qx3;

// XOR gate
wire xor_output;
assign xor_output = x ^ q1;

// AND gate
wire and_output;
assign and_output = qx2 & q2;

// OR gate
wire or_output;
assign or_output = qx3 | q3;

// XNOR gate
assign z = ~(xor_output ^ and_output ^ or_output);

// D flip-flops
always @(posedge clk) begin
	q1 <= d1;
	q2 <= d2;
	q3 <= d3;
end

// D flip-flop initial value
initial begin
	d1 <= 1'b0;
	d2 <= 1'b0;
	d3 <= 1'b0;
end

endmodule
