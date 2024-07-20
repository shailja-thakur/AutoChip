module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 0;
		else if (slowena)
			case (q)
				0 : q <= 1;
				1 : q <= 2;
				2 : q <= 3;
				3 : q <= 4;
				4 : q <= 5;
				5 : q <= 6;
				6 : q <= 7;
				7 : q <= 8;
				8 : q <= 9;
				9 : q <= 0;
			endcase
	end

endmodule
