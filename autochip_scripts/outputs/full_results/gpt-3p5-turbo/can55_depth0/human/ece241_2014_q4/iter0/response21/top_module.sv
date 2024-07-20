module top_module (
	input clk,
	input x,
	output z
);

reg d1, d2, d3; // flip-flop outputs
wire not_d1, not_d2, not_d3; // flip-flop complemented outputs

assign not_d1 = ~d1;
assign not_d2 = ~d2;
assign not_d3 = ~d3;

xor gate1 (d1, x, d1); // XOR gate with input x and flip-flop output
and gate2 (d2, x, not_d2); // AND gate with input x and flip-flop complemented output
or gate3 (d3, x, not_d3); // OR gate with input x and flip-flop complemented output

xnor gate4 (z, d1, d2, d3); // XNOR gate with flip-flop outputs

always @(posedge clk) begin
	d1 <= gate1;
	d2 <= gate2;
	d3 <= gate3;
end

endmodule
