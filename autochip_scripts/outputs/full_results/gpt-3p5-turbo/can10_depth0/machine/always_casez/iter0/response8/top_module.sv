module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

always @(in)
  casez(in)
    8'bzzzzzzz1: pos <= 3'b000;  // Position 0
    8'bz1zzzzzz: pos <= 3'b110;  // Position 6
    default: pos <= 3'b000;       // Default position
  endcase

endmodule
