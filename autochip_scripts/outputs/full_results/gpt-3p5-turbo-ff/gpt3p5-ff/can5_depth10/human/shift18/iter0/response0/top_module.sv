module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q); 
  
  reg [63:0] shift_reg;

  always @(posedge clk) begin
    if (load == 1'b1) begin
      shift_reg <= data; // Load register with data when load signal is high
    end else if (ena == 1'b1) begin
      case (amount)
        2'b00: // Shift left by 1 bit
          shift_reg <= shift_reg << 1;
        2'b01: // Shift left by 8 bits
          shift_reg <= shift_reg << 8;
        2'b10: // Shift right by 1 bit (arithmetic shift)
          shift_reg <= shift_reg >>> 1;
        2'b11: // Shift right by 8 bits (arithmetic shift)
          shift_reg <= shift_reg >>> 8;
      endcase
    end
  end

  assign q = shift_reg;
endmodule
