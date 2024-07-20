module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Declare the D flops
	reg [3:0] d;

	// Declare the outputs
	wire [3:0] q;

	// Implement the shift register with D flops
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			d <= 4'b0;
		end else begin
			d <= {d[2:0], in};
		end
	end

	// Assign the outputs
	assign out = d[3];
	assign q = d;

endmodule
