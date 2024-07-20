module top_module (
  input [7:0] in,
  output reg [2:0] pos
);

always @(in) begin
  casez(in)
    8'b000_000_01: pos <= 3'b0;      // 8'bzzzzzzz1
    8'b000_000_10: pos <= 3'b1;      // 8'bzzzzzz1z
    8'b000_001_00: pos <= 3'b2;      // 8'bzzzzz1zz
    8'b000_010_00: pos <= 3'b3;      // 8'bzzzz1zzz
    8'b000_100_00: pos <= 3'b4;      // 8'bzzz1zzzz
    8'b001_000_00: pos <= 3'b5;      // 8'bzz1zzzzz
    8'b010_000_00: pos <= 3'b6;      // 8'bz1zzzzzz
    default: pos <= 3'b0;
  endcase
end

endmodule
