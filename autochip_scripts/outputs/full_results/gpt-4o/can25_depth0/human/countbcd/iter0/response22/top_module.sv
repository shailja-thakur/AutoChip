module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal wires for the counter increments
	wire ena1, ena2, ena3;
	
	assign ena1 = (q[3:0] == 4'd9);        // Enable for tens digit
	assign ena2 = (q[7:4] == 4'd9) && ena1; // Enable for hundreds digit
	assign ena3 = (q[11:8] == 4'd9) && ena2; // Enable for thousands digit
	
	assign ena = {ena3, ena2, ena1}; // Assign enable signals

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'd0;
		end
		else begin
			// Ones digit
			if (q[3:0] == 4'd9) q[3:0] <= 4'd0;
			else q[3:0] <= q[3:0] + 1;

			// Tens digit
			if (ena1) begin
				if (q[7:4] == 4'd9) q[7:4] <= 4'd0;
				else q[7:4] <= q[7:4] + 1;
			end

			// Hundreds digit
			if (ena2) begin
				if (q[11:8] == 4'd9) q[11:8] <= 4'd0;
				else q[11:8] <= q[11:8] + 1;
			end

			// Thousands digit
			if (ena3) begin
				if (q[15:12] == 4'd9) q[15:12] <= 4'd0;
				else q[15:12] <= q[15:12] + 1;
			end
		end
	end
endmodule
