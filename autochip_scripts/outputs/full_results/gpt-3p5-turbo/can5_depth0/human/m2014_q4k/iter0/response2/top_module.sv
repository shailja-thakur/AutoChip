module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Declare D flip-flops
	reg [3:0] d;

	// D flip-flop input
	assign d[0] = in;

	// Shift register output
	assign out = d[3];

	// Clock and resetn control for D flip-flops
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			d <= 4'b0;
		end else begin
			d <= {d[2:0], in};
		end
	end
endmodule
