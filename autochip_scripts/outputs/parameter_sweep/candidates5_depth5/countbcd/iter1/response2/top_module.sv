module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

reg [3:0] q_temp; // Temporary variable to store the incremented value

always @(posedge clk or posedge reset) begin
	if(reset) begin
		q <= 0;
		q_temp <= 0;
	end else begin
		if(ena[1]) begin
			q_temp[7:4] <= q[7:4] + 1;
		end else begin
			q_temp[7:4] <= q[7:4];
		end
		
		if(ena[2]) begin
			q_temp[11:8] <= q[11:8] + 1;
		end else begin
			q_temp[11:8] <= q[11:8];
		end
		
		if(ena[3]) begin
			q_temp[15:12] <= q[15:12] + 1;
		end else begin
			q_temp[15:12] <= q[15:12];
		end
		
		q[3:0] <= q_temp[3:0];
		q[7:4] <= q_temp[7:4];
		q[11:8] <= q_temp[11:8];
		q[15:12] <= q_temp[15:12];
	end
end

endmodule
