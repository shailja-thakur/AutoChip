module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_reg;

	always @(posedge clk) begin
		q_reg <= d;
	end

	initial begin
		// Assign the initial value to q_reg to avoid race conditions
		q_reg = 8'b0;
	end

	// Synchronize the output q with the clock
	always @(posedge clk) begin
		q <= q_reg;
	end

endmodule
