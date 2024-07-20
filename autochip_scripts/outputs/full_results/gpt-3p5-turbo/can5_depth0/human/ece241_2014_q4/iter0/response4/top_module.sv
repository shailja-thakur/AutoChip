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

xor gate1(q1, d1, x);
and gate2(q2, d2, ~x);
or gate3(q3, d3, ~x);

xnor xnor_gate(z, q1, q2, q3);

always @(posedge clk) begin
	if (rst) begin
		d1 <= 1'b0;
		d2 <= 1'b0;
		d3 <= 1'b0;
	else begin
		d1 <= gate1;
		d2 <= gate2;
		d3 <= gate3;
	end
end

endmodule
