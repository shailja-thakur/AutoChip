module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal wires and registers
	reg [3:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
		end else if (count == 9) begin
			count <= 0;
		end else begin
			count <= count + 1;
		end
	end

	// Output assignment
	assign q = count;

endmodule
