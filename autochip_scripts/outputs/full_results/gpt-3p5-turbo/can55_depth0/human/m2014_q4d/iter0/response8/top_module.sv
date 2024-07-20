module top_module (
	input clk,
	input in,
	output logic out
);

// D Flip-Flop
logic d;
always @(posedge clk) begin
	d <= in ^ out;
	out <= d;
end

endmodule
