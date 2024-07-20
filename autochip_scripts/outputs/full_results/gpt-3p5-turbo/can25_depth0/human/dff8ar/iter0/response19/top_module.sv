module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	reg [7:0] q_temp; // Temporary register to hold intermediate values

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q_temp <= 8'b0; // Reset all DFFs to 0
		end 
		else begin
			q_temp <= d; // Update the DFFs with the input values 
		end
	end

	always @(posedge clk) begin
		if (!areset) begin
			q <= q_temp; // Update the output with the values from the temporary register
		end
	end

endmodule
