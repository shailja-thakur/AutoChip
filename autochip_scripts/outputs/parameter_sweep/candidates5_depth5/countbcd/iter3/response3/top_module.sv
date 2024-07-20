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
		q_next <= 0; // Added reset condition for q_next as well
	end else begin
		q <= q_next;
		ena <= ena; // Added assignment for ena to maintain its value
		q_next <= q_next; // Added assignment for q_next to maintain its value
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
