module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
   
   always @(*) begin
      case ({a, b, c, d})
         2'b0000: out = 1'b0;
         2'b0001: out = 1'b0;
         2'b0011: out = 1'b1;
         2'b0010: out = 1'b1;
         2'b0100: out = 1'bx;
         2'b0101: out = 1'b0;
         2'b0111: out = 1'b0;
         2'b0110: out = 1'b0;
         2'b1100: out = 1'b1;
         2'b1101: out = 1'bx;
         2'b1111: out = 1'b1;
         2'b1110: out = 1'b1;
         2'b1000: out = 1'b1;
         2'b1001: out = 1'bx;
         2'b1011: out = 1'b1;
         2'b1010: out = 1'b1;
         default: out = 0;
      endcase
   end

endmodule
