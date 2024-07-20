module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else if (ena) begin
      case (amount)
        2'b00: q <= q << 1;        // Shift left by 1 bit
        2'b01: q <= q << 8;        // Shift left by 8 bits
        2'b10: q <= q >> 1;        // Shift right by 1 bit (arithmetic right shift)
        2'b11: q <= q >> 8;        // Shift right by 8 bits (arithmetic right shift)
        default: q <= q;           // No shift
      endcase
    end
  end
endmodule
