module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	// parameter declaration
	parameter A = 0;
	parameter B = 1;

	// state register declaration
	reg [1:0] state;
	// output wire declaration
	wire output_z;

	// state register initialization
	always @(posedge clk or negedge areset) begin
		if (~areset)
			state <= A;
		else
			state <= (state == A && x) ? B : state;
	end

	// output assignment
	assign output_z = (state == A && x) || (state == B && !x);

	// output assignment for z
	assign z = output_z;

endmodule
