module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

  always @*
    case(in)
      8'b0zzzzzz1: pos = 3'b000;
      8'b0z1zzzzz: pos = 3'b001;
      8'b0z1zzzz1: pos = 3'b010;
      8'b0z11zzzz: pos = 3'b011;
      8'b1zzzzzzz: pos = 3'b100;
      8'b10zzzzzz: pos = 3'b101;
      8'b110zzzzz: pos = 3'b110;
      8'b111zzzzz: pos = 3'b111;
      default: pos = 0;
    endcase
  
endmodule
