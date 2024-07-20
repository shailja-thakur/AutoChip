module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	reg [2:0] q;

	// Submodule instance 1
	flipflop_module flipflop_1 (.clk(clk), .reset(L), .d(q_in), .q(q[0]));

	// Submodule instance 2
	mux21_module mux21_1 (.a(q[0]), .b(r_in), .sel(L), .y(q[1]));

	// Submodule instance 3
	flipflop_module flipflop_2 (.clk(clk), .reset(L), .d(q[1]), .q(q[2]));

	// Output assignment
	assign Q = q[2];

endmodule
module flipflop_module(
	input clk,
	input reset,
	input d,
	output reg q);
	
	always @(posedge clk) begin
		if (reset) begin
			q <= 1'b0;
		end else begin
			q <= d;
		end
	end
	
endmodule
module mux21_module(
	input a,
	input b,
	input sel,
	output reg y);
	
	always @(a, b, sel) begin
		if (sel) begin
			y <= b;
		end else begin
			y <= a;
		end
	end
	
endmodule
