module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	// intermediate enable signals for each digit
	reg [3:0] carry;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'd0;
			carry <= 4'd0;
		end else begin
			// increment the ones place
			if (q[3:0] == 4'd9) begin
				q[3:0] <= 4'd0;
				carry[0] <= 1'b1;
			end else begin
				q[3:0] <= q[3:0] + 1;
				carry[0] <= 1'b0;
			end
			
			// increment the tens place
			if (carry[0]) begin
				if (q[7:4] == 4'd9) begin
					q[7:4] <= 4'd0;
					carry[1] <= 1'b1;
				end else begin
					q[7:4] <= q[7:4] + 1;
					carry[1] <= 1'b0;
				end
			end else
				carry[1] <= 1'b0;

			// increment the hundreds place
			if (carry[1]) begin
				if (q[11:8] == 4'd9) begin
					q[11:8] <= 4'd0;
					carry[2] <= 1'b1;
				end else begin
					q[11:8] <= q[11:8] + 1;
					carry[2] <= 1'b0;
				end
			end else
				carry[2] <= 1'b0;

			// increment the thousands place
			if (carry[2]) begin
				if (q[15:12] == 4'd9) begin
					q[15:12] <= 4'd0;
				end else begin
					q[15:12] <= q[15:12] + 1;
				end
			end
		end
	end

	// define enable signals
	assign ena[1] = carry[0];
	assign ena[2] = carry[1];
	assign ena[3] = carry[2];

endmodule
