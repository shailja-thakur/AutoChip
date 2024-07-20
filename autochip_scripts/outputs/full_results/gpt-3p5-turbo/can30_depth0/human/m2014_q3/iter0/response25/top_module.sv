module top_module (
	input [4:1] x,
	output logic f
);
  
  always_comb begin
    case (x)
      4'b00??: f = 1;     // don't care
      4'b01??: f = x[2];  // output 0 or 1
      4'b11??: f = 1;     // output 1
      4'b10??: f = x[3];  // output 0 or 1
      default: f = 0;     // default output
    endcase
  end
  
endmodule
