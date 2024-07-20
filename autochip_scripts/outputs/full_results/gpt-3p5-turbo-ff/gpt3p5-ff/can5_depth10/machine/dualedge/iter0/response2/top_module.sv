module top_module(
	input clk,
	input d,
	output reg q);

	// Register declarations
	reg qp;
	reg qn;

	// Always block to update the registers
	always @(posedge clk or negedge clk) begin
		if (clk) begin
			qp <= d;
		end
		else begin
			qn <= d;
		end
	end

	// Assign the synchronized value to output port q
	always @(posedge clk or negedge clk) begin
		if (clk) begin
			q <= qp;
		end
		else begin
			q <= qn;
		end
	end

endmodule
