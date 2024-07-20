module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_temp; // Temporary register to hold the intermediate output values

	always @(posedge clk) begin
		if (reset) begin
			q_temp <= 8'b0; // Reset the temporary register
		end else begin
			q_temp <= d; // Update the temporary register with the input values
		end
	end

	assign q = q_temp; // Assign the temporary register to the output register

endmodule
