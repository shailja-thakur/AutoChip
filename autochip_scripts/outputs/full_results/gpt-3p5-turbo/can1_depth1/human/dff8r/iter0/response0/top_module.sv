module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] dff [0:7]; // Create an array of 8 D flip-flops

	always @(posedge clk) begin
		if(reset) begin
			q <= 8'b0; // Reset output to zero
		end
		else begin
			for(int i=0; i<8; i=i+1) begin
				dff[i] <= d[i]; // Update D input of each flip-flop
				q[i] <= dff[i]; // Update output of each flip-flop
			end
		end
	end
endmodule
