module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);
	
	// Create 8 D flip-flops
	reg [7:0] q_temp;
	always @ (negedge clk or posedge reset) begin
		if (reset)
			q_temp <= 8'b00110100; // reset to 0x34
		else
			q_temp <= d;
	end
	
	// Assign the values of q_temp to q
	assign q = q_temp;
	
endmodule
