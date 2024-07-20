module top_module (
	input clk,
	input in,
	output logic out
);

	// D flip-flop with positive edge trigger
	logic d;
	always_ff @(posedge clk)
		d <= in ^ out;

	// Output assignment
	assign out = d;
  
endmodule
