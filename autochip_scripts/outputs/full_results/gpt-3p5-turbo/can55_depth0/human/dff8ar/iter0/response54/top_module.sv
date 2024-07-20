module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);
	
	reg [7:0] q_temp; // Temporary register to store intermediate values
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			q_temp <= 8'b0; // Reset the temporary register to 0
		else
			q_temp <= d; // Store the input to the temporary register
	end
	
	always @(posedge clk) begin
		if (!areset)
			q <= q_temp; // Update the output register with the value from the temporary register
	end

endmodule
