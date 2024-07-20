module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [31:0] count;
	reg [31:0] result;
	reg z;

	always @(posedge clk or negedge areset) begin
		if (areset == 0) begin
			count <= 0;
			result <= 0;
		end else begin
			count <= count + 1;
			result <= (x[count]) ? ~result + 1 : result;
		end
	end

	assign z = (areset == 0) ? 0 : result;

endmodule
