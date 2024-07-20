module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  reg [255:0] in_reg [0:3];
  integer i;

  always @* begin
    for (i = 0; i < 4; i = i + 1) begin
      in_reg[i] = in[(i * 256) +: 256];
    end

    case (sel)
      0: out = in_reg[0][3:0];
      1: out = in_reg[1][3:0];
      2: out = in_reg[2][3:0];
      3: out = in_reg[3][3:0];
      default: out = 0;
    endcase
  end

endmodule
