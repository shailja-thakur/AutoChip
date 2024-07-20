module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define the D flip-flops
	reg [3:0] d;
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
			d <= 4'b0;
		else
			d <= {d[2:0], in};
	end
	
	// Assign the output to the last flip-flop
	assign out = d[3];
endmodule
