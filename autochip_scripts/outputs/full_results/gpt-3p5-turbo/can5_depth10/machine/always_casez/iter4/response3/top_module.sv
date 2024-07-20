module top_module (
  input [7:0] in,
  output reg [2:0] pos
);
  
always @* begin
  case(in)
    8'b0_000_0001: pos = 3'b000;
    8'b0_000_001x: pos = 3'b001;
    8'b0_000_01xx: pos = 3'b010;
    8'b0_000_1xxx: pos = 3'b011;
    8'b0_001_xxxx: pos = 3'b100;
    8'b0_01_xx_xxx: pos = 3'b101;
    8'b0_1x_xxx_xxx: pos = 3'b110;
    8'b1x_xxx_xxx_x: pos = 3'b111;
    default: pos = 3'b000;
  endcase
end

endmodule
