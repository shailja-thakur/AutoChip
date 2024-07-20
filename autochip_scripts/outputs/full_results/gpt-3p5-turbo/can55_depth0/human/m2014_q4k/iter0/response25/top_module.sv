module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	// Define internal signals
	reg [3:0] d;
	wire [3:0] q;
	
	// Instantiate D flip-flops
	dff dff0 (.clk(clk), .resetn(resetn), .d(in), .q(q[0]));
	dff dff1 (.clk(clk), .resetn(resetn), .d(q[0]), .q(q[1]));
	dff dff2 (.clk(clk), .resetn(resetn), .d(q[1]), .q(q[2]));
	dff dff3 (.clk(clk), .resetn(resetn), .d(q[2]), .q(q[3]));
	
	// Output connection
	assign out = q[3];
endmodule
module dff (
	input clk,
	input resetn,
	input d,
	output q
);
	reg q_reg;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			q_reg <= 1'b0;
		else
			q_reg <= d;
	end
	
	assign q = q_reg;
endmodule
