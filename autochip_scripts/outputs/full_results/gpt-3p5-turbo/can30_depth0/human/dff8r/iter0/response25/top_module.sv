module top_module (
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q
);
	// Create 8 D flip-flops
	reg [7:0] q_temp;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_temp <= 8'b0; // Set outputs to zero on reset
		end else begin
			q_temp <= d; // Assign input to output
		end
	end
	
	// Assign q_temp to q
	assign q = q_temp;
	
endmodule
