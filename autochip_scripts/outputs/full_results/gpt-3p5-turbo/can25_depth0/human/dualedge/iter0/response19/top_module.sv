module top_module(
	input clk,
	input d,
	output reg q);

	// Register variables for storing intermediate values
	reg q_reg1;
	reg q_reg2;

	// D flip-flop triggered on positive edge of clock
	always @(posedge clk) begin
		q_reg1 <= d;
	end

	// D flip-flop triggered on negative edge of clock
	always @(negedge clk) begin
		q_reg2 <= q_reg1;
	end

	// Assign final output
	assign q = q_reg2;

endmodule
