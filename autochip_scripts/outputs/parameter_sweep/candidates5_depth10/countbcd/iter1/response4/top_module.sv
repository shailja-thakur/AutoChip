module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
	
	reg [15:0] q_next;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 0;
		end else begin
			q <= q_next;
		end
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_next <= 0;
			ena <= 0;
		end else if (ena[1]) begin
			q_next[3:0] <= q[3:0] + 1;
			ena <= ena;
		end else begin
			q_next[3:0] <= q[3:0];
			ena <= ena;
		end
		
		if (reset) begin
			q_next[7:4] <= 0;
			ena[2] <= 0;
		end else if (ena[2]) begin
			q_next[7:4] <= q[7:4] + 1;
			ena[2] <= ena[2];
		end else begin
			q_next[7:4] <= q[7:4];
			ena[2] <= ena[2];
		end
		
		if (reset) begin
			q_next[11:8] <= 0;
			ena[3] <= 0;
		end else if (ena[3]) begin
			q_next[11:8] <= q[11:8] + 1;
			ena[3] <= ena[3];
		end else begin
			q_next[11:8] <= q[11:8];
			ena[3] <= ena[3];
		end
		
		if (reset) begin
			q_next[15:12] <= 0;
		end else if (ena[3]) begin
			q_next[15:12] <= q[15:12] + 1;
		end else begin
			q_next[15:12] <= q[15:12];
		end
	end
	
	assign ena = q[7:1];
endmodule
