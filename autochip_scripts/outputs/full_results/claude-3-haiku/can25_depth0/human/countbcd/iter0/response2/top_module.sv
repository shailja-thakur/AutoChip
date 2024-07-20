module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Combinational logic to generate the enable signals
	assign ena[1] = (q[3:0] == 4'b1001); // Increment tens when ones digit is 9
	assign ena[2] = (q[7:4] == 4'b1001); // Increment hundreds when tens digit is 9
	assign ena[3] = (q[11:8] == 4'b1001); // Increment thousands when hundreds digit is 9

	always @(posedge clk) begin
		if (reset) begin
			q <= 16'b0; // Reset the counter to 0
		end
		else begin
			// Increment the counter
			if (ena[1]) q[3:0] <= 4'b0000; // Reset ones digit when it reaches 9
			else q[3:0] <= q[3:0] + 1'b1; // Increment ones digit

			if (ena[1]) q[7:4] <= q[7:4] + 1'b1; // Increment tens digit when ones digit is 9
			if (ena[2]) q[7:4] <= 4'b0000; // Reset tens digit when it reaches 9

			if (ena[2]) q[11:8] <= q[11:8] + 1'b1; // Increment hundreds digit when tens digit is 9
			if (ena[3]) q[11:8] <= 4'b0000; // Reset hundreds digit when it reaches 9

			if (ena[3]) q[15:12] <= q[15:12] + 1'b1; // Increment thousands digit when hundreds digit is 9
		end
	end

endmodule
