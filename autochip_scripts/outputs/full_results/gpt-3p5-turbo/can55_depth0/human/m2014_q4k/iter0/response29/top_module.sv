module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define the D flop
	reg d1, d2, d3, d4;

	// Output of the shift register
	wire out;

	// Implement the shift register
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			d1 <= 1'b0;
			d2 <= 1'b0;
			d3 <= 1'b0;
			d4 <= 1'b0;
		end else begin
			d1 <= in;
			d2 <= d1;
			d3 <= d2;
			d4 <= d3;
		end
	end

	// Assign the output
	assign out = d4;
endmodule
