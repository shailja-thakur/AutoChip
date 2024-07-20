module top_module (
	input clk,
	input in,
	output logic out
);

logic xor_output;

// Compute the XOR of input and current output of flip-flop
assign xor_output = in ^ out;

// Positive edge-triggered D flip-flop
always_ff @(posedge clk) begin
	out <= xor_output;
end

endmodule
