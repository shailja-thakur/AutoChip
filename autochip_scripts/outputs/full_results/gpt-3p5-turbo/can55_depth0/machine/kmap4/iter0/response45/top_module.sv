module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

  always @* begin
    case ({a, b, c, d})
      4'd0: out = 1'b0;
      4'd1: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule
