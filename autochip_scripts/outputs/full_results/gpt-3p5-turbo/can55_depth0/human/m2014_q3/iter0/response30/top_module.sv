module top_module (
	input  [4:1] x,
	output logic f
);
  
  always_comb begin
    case (x)
      4'b00??: f = 1; // choose to output 1 for don't-care condition
      4'b010?: f = 0;
      4'b011?: f = 1;
      4'b01??: f = 0; // choose to output 0 for don't-care condition
      4'b10??: f = 1;
      4'b11??: f = 1;
      4'b1???: f = 0; // choose to output 0 for don't-care condition
      default: f = 0; // choose to output 0 for any other inputs
    endcase
  end

endmodule
