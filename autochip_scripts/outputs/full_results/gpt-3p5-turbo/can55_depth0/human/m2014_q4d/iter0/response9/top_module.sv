module top_module (
	input clk,
	input in,
	output logic out
);

// D flip-flop
logic d;
always_ff @(posedge clk) begin
	d <= in ^ out;
end

// Output of the flip-flop
assign out = d;

endmodule
