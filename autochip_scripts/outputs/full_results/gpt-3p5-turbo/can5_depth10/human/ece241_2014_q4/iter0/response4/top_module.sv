module top_module (
	input clk,
	input x,
	output z
);

reg flipflop1, flipflop2, flipflop3;
wire xor_output, and_output, or_output;

// D flip-flops
always @(posedge clk) begin
	flipflop1 <= xor_output;
	flipflop2 <= ~flipflop1;
	flipflop3 <= ~flipflop2;
end

// Three-input gates
assign xor_output = x ^ flipflop1;
assign and_output = x & ~flipflop2;
assign or_output = x | ~flipflop3;

// Three-input XNOR gate
assign z = xor_output ^ and_output ^ or_output;

endmodule
