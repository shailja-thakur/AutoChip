module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

  always @* begin
    case ({a, b, c, d, e})
      5'b0_0000: q = b;
      5'b0_0001: q = e;
      5'b0_0010: q = d;
      5'b0_0011: q = f;
      //Additional cases
      5'b0_0100: q = f;
      5'b0_0101: q = f;
      5'b0_0110: q = f;
      5'b0_0111: q = f;
      5'b0_1000: q = f;
      5'b0_1001: q = f;
      5'b0_1010: q = f;
      5'b0_1011: q = f;
      5'b0_1100: q = f;
      5'b0_1101: q = f;
      5'b0_1110: q = f;
      default: q = f;
    endcase
  end
endmodule
