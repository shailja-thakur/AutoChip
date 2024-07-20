module top_module (
  input clk,
  input enable,
  input S,
  input A,
  input B,
  input C,
  output reg [7:0] q,
  output reg Z
); 

// Define internal wires and registers
reg [7:0] shift_reg; // 8-bit register

// Enable the shift register
always @(posedge clk) begin
  if (enable)
    shift_reg <= {S, shift_reg[7:1]}; // shift in S to the left, maintaining the previous values
end

// Multiplexer for selecting the output bit
always @(*) begin
  case ({A, B, C})
    3'b000: Z = shift_reg[0];
    3'b001: Z = shift_reg[1];
    3'b010: Z = shift_reg[2];
    3'b011: Z = shift_reg[3];
    3'b100: Z = shift_reg[4];
    3'b101: Z = shift_reg[5];
    3'b110: Z = shift_reg[6];
    3'b111: Z = shift_reg[7];
    default: Z = 0; // default value
  endcase
end

endmodule
