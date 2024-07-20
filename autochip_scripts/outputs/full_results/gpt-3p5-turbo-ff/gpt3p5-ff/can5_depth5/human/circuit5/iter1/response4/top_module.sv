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
      5'b0_01__: q = 'b1111; // f when c is all zeros
      default: q = 'b1111; // f for all other cases
    endcase
  end
endmodule
