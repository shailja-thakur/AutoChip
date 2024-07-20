module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

  always @(*) begin
    case (in)
      8'bxxxxxxx1: pos = 3'b000;
      8'bxxxxxx1x: pos = 3'b001;
      8'bxxxxx1xx: pos = 3'b010;
      8'bxxxx1xxx: pos = 3'b011;
      8'bxxx1xxxx: pos = 3'b100;
      8'bxx1xxxxx: pos = 3'b101;
      8'bx1xxxxxx: pos = 3'b110;
      default: pos = 0;
    endcase
  end

endmodule
