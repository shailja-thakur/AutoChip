module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

reg [15:0] q_next;

always @(posedge clk or posedge reset) begin
	if(reset) begin
		q <= 0;
		ena <= 0;
	end else begin
		q <= q_next;
	end
end

always @* begin
	q_next = q + 1;
	
	if(ena[1]) begin
		q_next[7:4] = q[7:4] + 1;
	end
	if(ena[2]) begin
		q_next[11:8] = q[11:8] + 1;
	end
	if(ena[3]) begin
		q_next[15:12] = q[15:12] + 1;
	end
end

endmodule
