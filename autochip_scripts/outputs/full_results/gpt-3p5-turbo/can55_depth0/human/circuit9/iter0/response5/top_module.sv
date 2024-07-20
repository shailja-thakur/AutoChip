module top_module(
	input clk,
	input a,
	output reg [2:0] q
);

  always @(posedge clk) begin
    case(q)
      0: if(a) q = 4;
         else q = 0;
      1: if(a) q = 5;
         else q = 1;
      2: if(a) q = 6;
         else q = 2;
      default: q = 0;
    endcase
  end
  
endmodule
