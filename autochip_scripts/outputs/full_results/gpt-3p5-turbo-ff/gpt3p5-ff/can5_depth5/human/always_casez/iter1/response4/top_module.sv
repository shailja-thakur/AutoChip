module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

  always @(*) begin
    casez(in)
      1'b1: pos = 1;
      1'b01: pos = 2;
      1'b001: pos = 3;
      1'b0001: pos = 4;
      1'b00001: pos = 5;
      1'b000001: pos = 6;
      1'b0000001: pos = 7;
      1'b00000001: pos = 8;
      default: pos = 0;
    endcase
  end

endmodule
