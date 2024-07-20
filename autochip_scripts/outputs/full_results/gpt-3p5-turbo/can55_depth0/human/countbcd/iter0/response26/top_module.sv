module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [15:0] q_next;

	always @(posedge clk, posedge reset) begin
		if (reset)
			q <= 0;
		else
			q <= q_next;
	end
	
	always @(posedge clk) begin
		if (reset)
			ena <= 3'b0;  // disable all enable signals during reset
		else
			ena <= {ena[2], ena[1], ena[0]};  // update enable signals
			
		if (ena[2])  // increment tens digit
			q_next[7:4] <= q[7:4] + 1;
		else
			q_next[7:4] <= q[7:4];
			
		if (ena[1])  // increment hundreds digit
			q_next[11:8] <= q[11:8] + 1;
		else
			q_next[11:8] <= q[11:8];
			
		if (ena[0])  // increment thousands digit
			q_next[15:12] <= q[15:12] + 1;
		else
			q_next[15:12] <= q[15:12];
	end
	
endmodule
