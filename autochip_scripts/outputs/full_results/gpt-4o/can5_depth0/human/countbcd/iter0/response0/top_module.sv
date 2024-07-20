module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// Internal enable signals for each BCD digit
	wire ena0, ena1, ena2, ena3;

	// Enable signals for higher digits
	assign ena[1] = q[3:0] == 4'd9;
	assign ena[2] = (q[7:4] == 4'd9) && ena[1];
	assign ena[3] = (q[11:8] == 4'd9) && ena[2];

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset all digits to 0
			q <= 16'd0;
		end else begin
			// Ones digit (q[3:0])
			if (q[3:0] == 4'd9) begin
				q[3:0] <= 4'd0;
			end else begin
				q[3:0] <= q[3:0] + 1;
			end

			// Tens digit (q[7:4])
			if (ena[1]) begin
				if (q[7:4] == 4'd9) begin
					q[7:4] <= 4'd0;
				end else begin
					q[7:4] <= q[7:4] + 1;
				end
			end

			// Hundreds digit (q[11:8])
			if (ena[2]) begin
				if (q[11:8] == 4'd9) begin
					q[11:8] <= 4'd0;
				end else begin
					q[11:8] <= q[11:8] + 1;
				end
			end

			// Thousands digit (q[15:12])
			if (ena[3]) begin
				if (q[15:12] == 4'd9) begin
					q[15:12] <= 4'd0;
				end else begin
					q[15:12] <= q[15:12] + 1;
				end
			end
		end
	end

endmodule
