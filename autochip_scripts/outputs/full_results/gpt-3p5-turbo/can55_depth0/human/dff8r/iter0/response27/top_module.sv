module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Define the internal wires and registers
	reg [7:0] q_temp;
	
	// Create 8 D flip-flops with active high synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			q_temp <= 8'b0;
		end else begin
			q_temp <= d;
		end
	end
	
	// Assign the output
	assign q = q_temp;
	
endmodule
