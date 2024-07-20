module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);
	
	reg [7:0] q_temp;  // temporary register to hold the intermediate values
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q_temp <= 8'b0;  // reset the temporary register to 0
		end else begin
			q_temp <= d;  // assign the input to the temporary register
		end
	end
	
	always @(posedge clk) begin
		if (!areset) begin
			q <= q_temp;  // assign the temporary register value to the output
		end
	end
	
endmodule
