module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal signal to hold the current count value
	reg [3:0] count;

	// Synchronous reset logic
	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
		end else begin
			if (count < 9) begin
				count <= count + 1;
			end else begin
				count <= 0;
			end
		end
	end

	// Output assignment
	assign q = count;
	
endmodule
