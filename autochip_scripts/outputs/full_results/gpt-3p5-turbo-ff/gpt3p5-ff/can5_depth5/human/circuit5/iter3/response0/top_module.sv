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
      5'b00000: q = 'b0010; // 2
      5'b00001: q = 'b0101; // 5
      5'b00010: q = 'b0001; // 1
      5'b00100: q = 'b0011; // 3
      default: q = 'b1111; // f
    endcase
  end
endmodule
