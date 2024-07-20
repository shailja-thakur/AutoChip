module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_temp; // temporary output register for synchronous reset

	always @(posedge clk) begin
		if (reset)
			q_temp <= 8'b0; // set q_temp to zero on reset
		else
			q_temp <= d; // update q_temp with input data
	end

	always @(posedge clk) begin
		if (reset)
			q <= 8'b0; // set q to zero on reset
		else
			q <= q_temp; // update q with q_temp on positive edge of clock
	end
endmodule
