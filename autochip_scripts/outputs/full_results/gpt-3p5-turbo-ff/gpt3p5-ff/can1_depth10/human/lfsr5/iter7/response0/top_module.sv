module top_module(
  input clk,
  input reset,
  output reg [4:0] q);

  reg [4:0] lfsr;
  reg [4:0] next_lfsr;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      lfsr <= 5'b10000;
      q <= 1'b1;
    end else begin
      case (lfsr)
        5'b00001: next_lfsr = 5'b10010;
        5'b00010: next_lfsr = 5'b00101;
        5'b00100: next_lfsr = 5'b01001;
        5'b01000: next_lfsr = 5'b10011;
        5'b10000: next_lfsr = 5'b00001;
        default: next_lfsr = lfsr << 1;
      endcase
      
      lfsr <= next_lfsr;
      q <= lfsr;
    end
  end

endmodule
