module top_module (
	input [4:1] x,
	output logic f
);
  always_comb begin
    case(x)
      4'b00??: f = 0;  // don't-care condition
      4'b01??: f = x[3];  // output 0 if x[3] = 0, otherwise output 1
      4'b11??: f = 1;  // output 1
      4'b10??: f = (x[2] == 0) ? 0 : 1;  // output 0 if x[2] = 0, otherwise output 1
      default: f = 0;
    endcase
  end
endmodule
