module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Increment conditions for each BCD digit
	assign ena[1] = (q[3:0] == 4'd9); // Enable tens digit when units digit is 9
	assign ena[2] = ena[1] && (q[7:4] == 4'd9); // Enable hundreds digit when tens digit and units digit are 99
	assign ena[3] = ena[2] && (q[11:8] == 4'd9); // Enable thousands digit when hundreds, tens, and units are 999

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'd0; // Reset counter to 0000
		end else begin
			// Ones digit (q[3:0])
			if (q[3:0] == 4'd9) begin
				q[3:0] <= 4'd0; // Reset ones digit
			end else begin
				q[3:0] <= q[3:0] + 4'd1; // Increment ones digit
			end

			// Tens digit (q[7:4])
			if (ena[1]) begin
				if (q[7:4] == 4'd9) begin
					q[7:4] <= 4'd0; // Reset tens digit
				end else begin
					q[7:4] <= q[7:4] + 4'd1; // Increment tens digit
				end
			end

			// Hundreds digit (q[11:8])
			if (ena[2]) begin
				if (q[11:8] == 4'd9) begin
					q[11:8] <= 4'd0; // Reset hundreds digit
				end else begin
					q[11:8] <= q[11:8] + 4'd1; // Increment hundreds digit
				end
			end

			// Thousands digit (q[15:12])
			if (ena[3]) begin
				if (q[15:12] == 4'd9) begin
					q[15:12] <= 4'd0; // Reset thousands digit
				end else begin
					q[15:12] <= q[15:12] + 4'd1; // Increment thousands digit
				end
			end
		end
	end
endmodule
