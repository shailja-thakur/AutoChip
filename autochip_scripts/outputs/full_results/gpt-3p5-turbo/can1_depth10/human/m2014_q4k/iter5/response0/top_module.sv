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
			d <= {d[2:0], in};
		end
	end

	// Output assignment
	assign out = q[3];

	// Instantiate D flip-flops
	d_flipflop dff0 (.clk(clk), .resetn(resetn), .d(in), .q(q[0]));
	d_flipflop dff1 (.clk(clk), .resetn(resetn), .d(q[0]), .q(q[1]));
	d_flipflop dff2 (.clk(clk), .resetn(resetn), .d(q[1]), .q(q[2]));
	d_flipflop dff3 (.clk(clk), .resetn(resetn), .d(q[2]), .q(q[3]));

endmodule
module d_flipflop (
	input clk,
	input resetn,
	input d,
	output reg q
);
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end
endmodule
