module top_module (
   input a, 
   input b,
   input c,
   input d,
   output reg out
);
   always @(*)
   begin
      case({a, b, c, d})
         4'b0000: out = 1'b0;     // if a,b,c,d == 0, the output is 0;
         4'b0001: out = 1'b0;     // if a,b,c,d == 1, the output is 0;
         4'b0011: out = 1'b1;     // if a,b,c,d == 3, the output is 1;
         4'b0010: out = 1'b1;     // if a,b,c,d == 2, the output is 1;
         4'b0100: out = 1'bx;     // if a,b,c,d == 4, the output is 1'bx;
         4'b0101: out = 1'b0;     // if a,b,c,d == 5, the output is 0;
         4'b0111: out = 1'b0;     // if a,b,c,d == 7, the output is 0;
         4'b0110: out = 1'b0;     // if a,b,c,d == 6, the output is 0;
         4'b1100: out = 1'b1;     // if a,b,c,d == c, the output is 1;
         4'b1101: out = 1'bx;     // if a,b,c,d == d, the output is 1'bx;
         4'b1111: out = 1'b1;     // if a,b,c,d == f, the output is 1;
         4'b1110: out = 1'b1;     // if a,b,c,d == e, the output is 1;
         4'b1000: out = 1'b1;     // if a,b,c,d == 8, the output is 1;
         4'b1001: out = 1'bx;     // if a,b,c,d == 9, the output is 1'bx;
         4'b1011: out = 1'b1;     // if a,b,c,d == b, the output is 1;
         4'b1010: out = 1'b1;     // if a,b,c,d == a, the output is 1;
         default: out = 1'bx;     // default output is 1'bx
      endcase
   end
endmodule
