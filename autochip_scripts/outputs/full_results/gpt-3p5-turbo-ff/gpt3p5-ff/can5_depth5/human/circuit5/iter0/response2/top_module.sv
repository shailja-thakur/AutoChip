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
      5'b0_0010: q = a;
      5'b0_0011: q = d;
      5'b0_0100: q = 'b1111; // f
      5'b0_0101: q = 'b1111; // f
      5'b0_0110: q = 'b1111; // f
      5'b0_0111: q = 'b1111; // f
      5'b0_1___: q = 'b1111; // f
      default: q = 'b1111; // f
    endcase
  end
endmodule
