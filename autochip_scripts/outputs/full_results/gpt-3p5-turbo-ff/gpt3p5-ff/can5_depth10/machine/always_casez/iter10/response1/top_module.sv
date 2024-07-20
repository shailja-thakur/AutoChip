module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

  always @*
    case(in)
      8'b00000001: pos = 1'b0;
      8'b00000010: pos = 1'b1;
      8'b00000100: pos = 1'b2;
      8'b00001000: pos = 1'b3;
      8'b00010000: pos = 1'b4;
      8'b00100000: pos = 1'b5;
      8'b01000000: pos = 1'b6;
      8'b10000000: pos = 1'b7;
      default: pos = 1'b0;
    endcase
  
endmodule
