module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);
  
  always @(a or b or c or d)
  begin
    case ({a,b,c,d})
      4'd0: out = 1'b0;
      4'd1: out = 1'b1;
      4'd2: out = 1'b0;
      4'd3: out = 1'b1;
      4'd4: out = 1'b1;
      4'd5: out = 1'b0;
      4'd6: out = 1'b1;
      4'd7: out = 1'b0;
      default: out = 1'b0;
    endcase
  end
  
endmodule
