module top_module (
  input clk,
  input enable,
  input S,
  input [2:0] A,
  input [2:0] B,
  input [2:0] C,
  output reg Z,
  output reg [7:0] q
);

  reg [7:0] shift_reg;

  always@(posedge clk) begin
    if (enable) begin
      shift_reg <= S ? {S, shift_reg[7:1]} : shift_reg;
    end
    else begin
      shift_reg <= shift_reg;
    end
  end

  always@(*) begin
    case ({A, B, C})
      3'b000: Z = shift_reg[0];
      3'b001: Z = shift_reg[1];
      3'b010: Z = shift_reg[2];
      3'b011: Z = shift_reg[3];
      3'b100: Z = shift_reg[4];
      3'b101: Z = shift_reg[5];
      3'b110: Z = shift_reg[6];
      3'b111: Z = shift_reg[7];
      default: Z = 1'bz;
    endcase
  end

  assign q = shift_reg;

endmodule
