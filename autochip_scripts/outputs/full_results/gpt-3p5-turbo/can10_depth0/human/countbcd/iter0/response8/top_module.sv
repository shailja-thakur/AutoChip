module top_module(
	input clk,
	input reset,
	output reg [3:1] ena,
	output reg [15:0] q);

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			q <= 0;
			ena <= 0;
		end else begin
			ena <= {ena[2:1], 1};
			if(ena[3] && (q[3:0] == 9))
				q[3:0] <= 0;
			else if(ena[2] && (q[7:4] == 9))
				q[7:4] <= 0;
			else if(ena[1] && (q[11:8] == 9))
				q[11:8] <= 0;
			else if(q[15:12] == 9)
				q[15:12] <= 0;
			else
				q <= q + 1;
		end
	end

endmodule
