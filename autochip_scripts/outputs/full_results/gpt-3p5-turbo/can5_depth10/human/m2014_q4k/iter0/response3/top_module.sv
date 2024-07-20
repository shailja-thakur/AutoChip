module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Declare four D flip-flops
	reg [3:0] d_ff;

	// Output register
	reg out_reg;

	// Clock edge detection
	always @(posedge clk) begin
		if (!resetn)
			d_ff <= 4'b0;
		else
			d_ff <= {d_ff[2:0], in};
	end

	// Output assignment
	always @(posedge clk) begin
		if (!resetn)
			out_reg <= 0;
		else
			out_reg <= d_ff[3];
	end
	
	// Output port assignment
	assign out = out_reg;

endmodule
