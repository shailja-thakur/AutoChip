module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
   always @(*) begin
      if(sel >= 0 && sel <= 1019)
         out = in[sel+7:sel+4];
      else
         out = 4'hX; // Invalid selection range, assign unknown value to output
   end
endmodule
