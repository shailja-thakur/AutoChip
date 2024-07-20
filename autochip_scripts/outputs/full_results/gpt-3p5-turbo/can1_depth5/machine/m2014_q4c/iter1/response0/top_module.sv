module top_module (
	input wire clk,
	input wire d,
	input wire r,
	output wire q
);

	reg q_reg;  // output register

	always @(posedge clk) begin  // triggered on rising edge of clock
		if (r) begin  // reset is active
			q_reg <= 0;  // output set to 0
		end else begin
			q_reg <= d;  // output set to data input value
		end
	end

	assign q = q_reg;  // assign output register to output wire

endmodule
