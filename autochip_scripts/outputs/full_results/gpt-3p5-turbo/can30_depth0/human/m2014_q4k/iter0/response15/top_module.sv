module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Create the delay flops
	reg [3:0] d_flops;
	
	// Create the output wire
	wire out;
	
	// Assign the output wire to the last D flop
	assign out = d_flops[3];
	
	// Create the reset signal and assign it to the synchronous reset
	reg reset;
	assign reset = ~resetn;
	
	// Create the clocked process for the D flops
	always @(posedge clk or negedge resetn) begin
		if (~reset)
			d_flops <= 4'b0000;
		else
			d_flops <= {d_flops[2:0], in};
	end
	
endmodule
