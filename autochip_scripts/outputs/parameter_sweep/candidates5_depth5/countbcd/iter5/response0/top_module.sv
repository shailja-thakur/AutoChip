module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

reg [15:0] q_next;

always @(posedge clk) begin
	if(reset) begin
		q <= 0;
		ena <= 0;
	end else begin
		q <= q_next;
		ena <= ena; // Added this line to retain the value of ena
	end
end

always @* begin
	q_next = q + 1;

	if (q[3:0] == 9)
		ena[1] = 1;
	else
		ena[1] = 0;
	
	if (q[7:4] == 9)
		ena[2] = 1;
	else
		ena[2] = 0;
	
	if (q[11:8] == 9)
		ena[3] = 1;
	else
		ena[3] = 0;
	
	if(ena[1]) begin
		q_next[3:0] = 0;
	end
	if(ena[2]) begin
		q_next[7:4] = 0;
	end
	if(ena[3]) begin
		q_next[11:8] = 0;
	end
end

endmodule
