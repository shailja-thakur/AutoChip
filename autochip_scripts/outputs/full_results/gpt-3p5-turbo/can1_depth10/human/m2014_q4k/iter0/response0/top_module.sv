module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define D flip-flops
	reg [3:0] d;
	wire [3:0] q;

	// Shift Register Implementation
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			d <= 4'b0;
		end else begin
			d <= {in, d[3:1]};
		end
	end

	// Output assignment
	assign out = d[0];

endmodule
