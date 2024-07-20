module top_module (
	input clk,
	input a,
	input b,
	output q,
	output reg state
);
	reg q;
	
	always @(posedge clk) begin
		case (state)
			0: begin
				if (a & b)
					state <= 1;
			end
			1: begin
				state <= 0;
				q <= b;
			end
		endcase
	end
	
endmodule
