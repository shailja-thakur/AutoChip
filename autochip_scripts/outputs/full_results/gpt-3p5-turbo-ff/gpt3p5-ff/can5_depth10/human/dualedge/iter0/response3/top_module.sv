module top_module(
	input clk,
	input d,
	output reg q);

	// internal signals
	reg q_reg1, q_reg2; // intermediate registers for storing previous values of q
	wire d_reg1, d_reg2; // intermediate signals for storing previous values of d

	// assign previous values of q and d
	always @(posedge clk) begin
		q_reg1 <= q;
		d_reg1 <= d;
	end

	// assign values of intermediate signals
	assign d_reg2 = d_reg1;
	assign q_reg2 = q_reg1;

	// flip-flop behavior
	always @(posedge clk) begin
		if (d_reg1 != d_reg2) begin
			q <= d;
		end
		else if (q_reg1 != q_reg2) begin
			q <= q_reg1;
		end
	end

endmodule
