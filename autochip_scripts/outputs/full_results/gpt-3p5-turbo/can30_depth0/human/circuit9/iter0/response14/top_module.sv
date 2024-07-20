module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);
	
	always @(posedge clk) begin
		if (a) begin
			case(q)
				3: q <= 4;
				4: q <= 5;
				5: q <= 6;
				6: q <= 0;
				0: q <= 1;
				1: q <= 2;
				default: q <= 0;
			endcase
		end
	end
	
endmodule
