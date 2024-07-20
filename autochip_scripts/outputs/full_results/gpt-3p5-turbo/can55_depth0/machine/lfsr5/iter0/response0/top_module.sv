module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
	// State transition always block
	always @(q) begin
		reg [4:1] q_next;
		
		q_next[4:1] = q[3:0];
		q_next[0] = q[4];
		q_next[2] = q[2] ^ q[4];
		
		q <= q_next;
	end
	
	// Logic description always block
	always @(posedge clk) begin
		if (reset) begin
			q <= 5'h1;
		end else begin
			q <= q_next;
		end
	end
	
endmodule
