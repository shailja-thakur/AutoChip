module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

  always @* begin
    case ({c, d, a, b})
      4'b0000: out = 1; // corresponds to 00
      4'b0001: out = 0; // corresponds to 01
      4'b0010: out = 1; // corresponds to 10
      default: out = 1; // corresponds to 11
    endcase
  end

endmodule
