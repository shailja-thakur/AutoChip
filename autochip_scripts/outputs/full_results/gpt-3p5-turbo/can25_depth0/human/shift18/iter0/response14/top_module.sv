module top_module(
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q);

  reg [63:0] shift_reg;  // Register to hold the shifted data

  always @(posedge clk) begin
    if (load) begin
      shift_reg <= data;  // Load the shift register with data
    end else if (ena) begin
      case (amount)
        2'b00: shift_reg <= shift_reg << 1;  // Shift left by 1 bit
        2'b01: shift_reg <= shift_reg << 8;  // Shift left by 8 bits
        2'b10: shift_reg <= shift_reg >>> 1; // Shift right by 1 bit (arithmetic right shift)
        2'b11: shift_reg <= shift_reg >>> 8; // Shift right by 8 bits (arithmetic right shift)
        default: shift_reg <= shift_reg;     // No shift
      endcase
    end else begin
      shift_reg <= shift_reg; // No operation
    end
  end

  assign q = shift_reg;  // Assign the contents of the shift register to output q

endmodule
