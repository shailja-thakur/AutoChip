module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	/* Always block triggered on positive edge of clk and areset signal */
	always @(posedge clk or posedge areset) begin
		/* Check state of areset signal */
		if (areset) begin
			q <= 0; /* Set q output to 0 */
		end else begin
			q <= d; /* Set q output to d input */
		end
	end

endmodule
