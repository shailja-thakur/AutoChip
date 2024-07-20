module top_module (
	input [4:1] x,
	output logic f
);
  
  // Define the truth table for the function f
  // x[3]x[4]   00 01 11 10
  //  00 | 1 | 0 | 0 | 1 |
  //  01 | 0 | 0 | 0 | 0 |
  //  11 | 1 | 1 | 1 | 0 |
  //  10 | 1 | 1 | 0 | 1 |
  
  always_comb begin
    case ({x[3], x[4]})
      2'b00: f = 1'b1;
      2'b01: f = 1'b0;
      2'b10: f = 1'b1;
      2'b11: f = 1'b0;
      default: f = 1'b0;
    endcase
  end
  
endmodule
