module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

  always @(in) begin
    casez(in)
      8'b1zzzzzzz: pos <= 3'b0;
      8'b01zzzzzz: pos <= 3'b1;
      8'b001zzzzz: pos <= 3'b2;
      8'b0001zzzz: pos <= 3'b3;
      8'b00001zzz: pos <= 3'b4;
      8'b000001zz: pos <= 3'b5;
      8'b0000001z: pos <= 3'b6;
      default: pos <= 3'b0;
    endcase
  end

endmodule
