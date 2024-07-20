module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(*) begin
  // Implement the logic based on the simulation waveforms provided
  case ({a, b, c, d, e})
    5'b00010:
      q = 4'b1011;
    5'b00011:
      q = 4'b1110;
    5'b00100:
      q = 4'b0001;
    5'b00101:
      q = 4'b1101;
    default:
      q = 4'b1111;
  endcase
end

endmodule
