module top_module (
  input clk,
  input x,
  input [2:0] y,
  output reg Y0,
  output reg z
);

  reg [2:0] Y;

  always @(posedge clk) begin
    case ({x, y})
      2'b00_000: Y <= 3'b00_000;
      2'b00_001: Y <= 3'b00_001;
      2'b01_010: Y <= 3'b00_001;
      2'b01_011: Y <= 3'b00_001;
      2'b01_100: Y <= 3'b01_100;
      2'b10_000: Y <= 3'b10_000;
      2'b10_001: Y <= 3'b10_001;
      2'b11_010: Y <= 3'b10_001;
      2'b11_011: Y <= 3'b10_010;
      2'b11_100: Y <= 3'b11_100;
      default: Y <= 3'b0_000;
    endcase
  end

  always @(posedge clk) begin
    Y0 <= Y[0];
    z <= (Y[2] ^ Y[1]);
  end

endmodule
