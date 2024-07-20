module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

  always @*
    casez(in)
      8'bzzz1zzzz: pos <= 3'b000;
      8'bz1zzzzzz: pos <= 3'b001;
      8'bz1zz1zzz: pos <= 3'b010;
      8'bz1zzzz1z: pos <= 3'b011;
      8'b1z1zzzzz: pos <= 3'b100;
      8'b1zz1zzzz: pos <= 3'b101;
      8'b1zzzz1zz: pos <= 3'b110;
      8'b1zzzzzz1: pos <= 3'b111;
      default: pos <= 3'b000;
    endcase
  
endmodule
