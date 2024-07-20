module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

 always @ (a, b, c, d) begin
   case ({c, d, a, b})
     4'b00x0: out = 1;
     4'b0101: out = 0;
     4'b00x1: out = 1;
     4'b01x0: out = 0;
     default: out = 1;
   endcase
 end

endmodule
