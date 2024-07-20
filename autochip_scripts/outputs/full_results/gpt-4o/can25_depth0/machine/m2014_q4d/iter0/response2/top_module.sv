module top_module (
	input clk,
	input in,
	output logic out
);

	// Define a reg for the output since it will be driven from an always block
	reg out_reg;
	assign out = out_reg;

	// Initial condition
	initial begin
		out_reg = 0;
	end

	// Always block to update the output on the rising edge of the clock
	always_ff @(posedge clk) begin
		out_reg <= in ^ out_reg;
	end

endmodule
