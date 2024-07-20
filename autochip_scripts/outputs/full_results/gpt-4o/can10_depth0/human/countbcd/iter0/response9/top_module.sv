module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		q <= 16'b0;
		ena <= 3'b0;
	end else begin
		// Increment the BCD counter
		if (q[3:0] == 4'd9) begin
			q[3:0] <= 4'd0;
			ena[1] <= 1'b1;
		end else begin
			q[3:0] <= q[3:0] + 1;
			ena[1] <= 1'b0;
		end
		
		if (ena[1]) begin
			if (q[7:4] == 4'd9) begin
				q[7:4] <= 4'd0;
				ena[2] <= 1'b1;
			end else begin
				q[7:4] <= q[7:4] + 1;
				ena[2] <= 1'b0;
			end
		end else begin
			ena[2] <= 1'b0;
		end
		
		if (ena[2]) begin
			if (q[11:8] == 4'd9) begin
				q[11:8] <= 4'd0;
				ena[3] <= 1'b1;
			end else begin
				q[11:8] <= q[11:8] + 1;
				ena[3] <= 1'b0;
			end
		end else begin
			ena[3] <= 1'b0;
		end
		
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
