module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk)
	begin
		case(q)
			3'b000: if(a) q <= 3'b100;
			3'b100: if(a) q <= 3'b000;
			3'b101: if(a) q <= 3'b000;
			default: q <= 3'b000;
		endcase
	end
endmodule
