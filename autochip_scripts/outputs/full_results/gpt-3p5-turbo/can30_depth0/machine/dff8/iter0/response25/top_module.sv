module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	/* initial block to set initial value of 'q' to 8'h0 */
	initial begin
		q = 8'h0;
	end
	
	/* always block triggered on rising edge of 'clk' */
	always @(posedge clk) begin
		q <= d; // the data input is stored in the register
	end

endmodule
