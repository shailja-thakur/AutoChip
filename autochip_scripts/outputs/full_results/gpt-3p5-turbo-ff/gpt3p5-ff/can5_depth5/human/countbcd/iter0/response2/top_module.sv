module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	// Internal wires and signals
	wire [3:0] q0;
	wire [3:0] q1;
	wire [3:0] q2;
	wire [3:0] q3;
	reg [2:0] count;
	
	// Ones digit counter
	always @(posedge clk or posedge reset) begin
		if (reset)
			count <= 0;
		else if (ena[1])
			count <= count + 1;
	end
	
	// Tens digit counter
	always @(posedge clk or posedge reset) begin
		if (reset)
			q0 <= 0;
		else if (ena[2])
			q0 <= q0 + 1;
	end
	
	// Hundreds digit counter
	always @(posedge clk or posedge reset) begin
		if (reset)
			q1 <= 0;
		else if (ena[3])
			q1 <= q1 + 1;
	end
	
	// Thousands digit counter
	always @(posedge clk or posedge reset) begin
		if (reset)
			q2 <= 0;
		else
			q2 <= q2 + 1;
	end
	
	// Combine counters
	assign q = {q3, q2, q1, q0};
	assign ena = {1, ena[2], ena[3]};
	
endmodule
