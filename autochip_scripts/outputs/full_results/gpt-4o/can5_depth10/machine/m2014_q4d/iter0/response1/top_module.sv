module top_module (
	input clk,
	input in,
	output logic out
);
	// Define a register to hold the output state
	logic out_reg = 0;

	// Always block triggered on the rising edge of the clock
	always_ff @(posedge clk) begin
		out_reg <= out_reg ^ in;
	end

	// Assign the register to the output
	assign out = out_reg;
endmodule
